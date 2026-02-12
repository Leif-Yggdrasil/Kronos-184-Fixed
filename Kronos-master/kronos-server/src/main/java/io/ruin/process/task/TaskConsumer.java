package io.ruin.process.task;

@FunctionalInterface
public interface TaskConsumer {
    void accept(Task0 task);
}