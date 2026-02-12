package io.ruin.process.event;

@FunctionalInterface
public interface EventConsumer {

    void accept(Event event);

}