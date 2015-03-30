package com.cyancloud.service.model;

import com.cyancloud.model.notice.Notice;

public class NoticeBean extends Notice {
	private String publisherName;

	public String getPublisherName() {
		return publisherName;
	}

	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}

}
