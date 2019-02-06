package com.lch.general.enums;

public enum TaskStatus {
	ACTIVE(1), COMPLETED(2), DELETED(3), IN_PROGRESS(4);

	private int taskId;

	public int getTaskId() {
		return taskId;
	}

	private TaskStatus(int id) {
		this.taskId = id;
	}
}
