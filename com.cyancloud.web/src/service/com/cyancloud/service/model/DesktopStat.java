package com.cyancloud.service.model;

public class DesktopStat {
	
	public Integer cpuAllSpeed=0; // MHZ

	public Integer cpuUsed=0;
	
	public Integer minCpu=0;
	
	public Integer maxCpu=0;

	public String recentTopTenCpuUsed="";

	public Long memory=0L; // 内存

	public Long memoryUsed=0L;
	
	public Long minMemory=0L;
	
	public Long maxMemory=0L;

	public String recnetTopTenMemUsed="";

	public Long storageCapacity=0L; // 总存储空间

	public Long storageFreeSpace=0L; // 存储剩余空间
	
	public Long minCapacity=0L;
	
	public Long maxCapacity=0L;
	
	public String recnetTopTenCapUsed="";
	
	public Integer desktopCount=0;
	
	public Integer desktopUsed=0;
	
	public Integer desktopActive=0;

	public Integer getCpuAllSpeed() {
		return cpuAllSpeed;
	}

	public void setCpuAllSpeed(Integer cpuAllSpeed) {
		this.cpuAllSpeed = cpuAllSpeed;
	}

	
	
	public Long getMinCapacity() {
		return minCapacity;
	}

	public void setMinCapacity(Long minCapacity) {
		this.minCapacity = minCapacity;
	}

	public Long getMaxCapacity() {
		return maxCapacity;
	}

	public void setMaxCapacity(Long maxCapacity) {
		this.maxCapacity = maxCapacity;
	}

	public Integer getCpuUsed() {
		return cpuUsed;
	}

	public void setCpuUsed(Integer cpuUsed) {
		this.cpuUsed = cpuUsed;
	}

	public Integer getMinCpu() {
		return minCpu;
	}

	public void setMinCpu(Integer minCpu) {
		this.minCpu = minCpu;
	}

	public Integer getMaxCpu() {
		return maxCpu;
	}

	public void setMaxCpu(Integer maxCpu) {
		this.maxCpu = maxCpu;
	}

	public String getRecentTopTenCpuUsed() {
		return recentTopTenCpuUsed;
	}

	public void setRecentTopTenCpuUsed(String recentTopTenCpuUsed) {
		this.recentTopTenCpuUsed = recentTopTenCpuUsed;
	}

	public Long getMemory() {
		return memory;
	}

	public void setMemory(Long memory) {
		this.memory = memory;
	}

	public Long getMemoryUsed() {
		return memoryUsed;
	}

	public void setMemoryUsed(Long memoryUsed) {
		this.memoryUsed = memoryUsed;
	}

	public Long getMinMemory() {
		return minMemory;
	}

	public void setMinMemory(Long minMemory) {
		this.minMemory = minMemory;
	}

	public Long getMaxMemory() {
		return maxMemory;
	}

	public void setMaxMemory(Long maxMemory) {
		this.maxMemory = maxMemory;
	}

	public String getRecnetTopTenMemUsed() {
		return recnetTopTenMemUsed;
	}

	public void setRecnetTopTenMemUsed(String recnetTopTenMemUsed) {
		this.recnetTopTenMemUsed = recnetTopTenMemUsed;
	}

	public Long getStorageCapacity() {
		return storageCapacity;
	}

	public void setStorageCapacity(Long storageCapacity) {
		this.storageCapacity = storageCapacity;
	}

	public Long getStorageFreeSpace() {
		return storageFreeSpace;
	}

	public void setStorageFreeSpace(Long storageFreeSpace) {
		this.storageFreeSpace = storageFreeSpace;
	}

	public String getRecnetTopTenCapUsed() {
		return recnetTopTenCapUsed;
	}

	public void setRecnetTopTenCapUsed(String recnetTopTenCapUsed) {
		this.recnetTopTenCapUsed = recnetTopTenCapUsed;
	}

	public Integer getDesktopCount() {
		return desktopCount;
	}

	public void setDesktopCount(Integer desktopCount) {
		this.desktopCount = desktopCount;
	}

	public Integer getDesktopUsed() {
		return desktopUsed;
	}

	public void setDesktopUsed(Integer desktopUsed) {
		this.desktopUsed = desktopUsed;
	}

	public Integer getDesktopActive() {
		return desktopActive;
	}

	public void setDesktopActive(Integer desktopActive) {
		this.desktopActive = desktopActive;
	}
	
	

}
