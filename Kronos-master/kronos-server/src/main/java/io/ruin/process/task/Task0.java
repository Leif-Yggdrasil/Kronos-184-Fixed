package io.ruin.process.task;

import io.ruin.Server;

public class Task0 {

    private final Thread thread;

    protected Task0(TaskConsumer consumer) {
        thread = Thread.ofVirtual().unstarted(() -> {
            try {
                consumer.accept(this);
            } catch (Throwable t) {
                Server.logError("", t);
            }
        });
    }

    protected Task0 start() {
        thread.start();
        return this;
    }

    public final void cancel() {
        thread.interrupt();
    }

    public final boolean isAlive() {
        return thread.isAlive();
    }

    public final void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public final void sync(Runnable runnable) {
        Server.worker.execute(runnable);
    }

}