package io.ruin.process.event;

import io.ruin.Server;
import io.ruin.model.entity.Entity;
import io.ruin.model.entity.player.Player;
import io.ruin.model.map.Position;
import jdk.internal.vm.Continuation;
import jdk.internal.vm.ContinuationScope;

import java.util.function.Supplier;

public class Event {

    private boolean ignoreCombatReset;

    public EventType eventType = EventType.DEFAULT;

    private final ContinuationScope scope;
    private final Continuation continuation;
    private int delayTicks;
    private Supplier<Boolean> cancelCondition;

    public Event(EventConsumer consumer) {
        scope = new ContinuationScope("EventScope");
        continuation = new Continuation(scope, () -> {
            try {
                consumer.accept(this);
            } catch (Throwable t) {
                Server.logError("", t);
            }
        });
    }

    public final boolean tick() {
        if (delayTicks > 0) {
            if (--delayTicks > 0)
                return true;
            if (cancelCondition != null && cancelCondition.get()) {
                return false;
            }
        }
        continuation.run();
        return !continuation.isDone();
    }

    public final void delay(int ticks) {
        delayTicks = ticks;
        Continuation.yield(scope);
    }

    public final void waitForMovement(Entity entity) {
        while(!entity.getMovement().isAtDestination())
            delay(1);
    }

    public final void waitForTile(Entity entity, Position position) {
        waitForTile(entity, position.getX(), position.getY());
    }

    public final void waitForTile(Entity entity, int x, int y) {
        while(!entity.isAt(x, y))
            delay(1);
    }

    public final Event ignoreCombatReset() {
        this.ignoreCombatReset = true;
        return this;
    }

    public boolean isIgnoreCombatReset() {
        return ignoreCombatReset;
    }

    public final void waitForDialogue(Player player) {
        while (player.hasDialogue())
            delay(1);
    }

    public final void path(Entity entity, Position... waypoints) {
        for (Position pos : waypoints) {
            entity.getRouteFinder().routeAbsolute(pos.getX(), pos.getY());
            waitForMovement(entity);
        }
    }

    public final void waitForCondition(Supplier<Boolean> condition, int timeout) {
        int time = 0;
        while (!condition.get() && time < timeout) {
            time++;
            delay(1);
        }
    }

    public final boolean persistent() {
        return eventType == EventType.PERSISTENT;
    }

    /**
     * When returning from a pause (delay), the given condition will be checked, and if met, the event will be stopped
     */
    public final void setCancelCondition(Supplier<Boolean> cancelCondition) {
        this.cancelCondition = cancelCondition;
    }
}