package com.ivucenter.cloud.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OssPvVO extends DataTableVO {

	private String projectBoxId;
	private String diskId;
	private String deviceUuid;
	private String storageContainerUuid;
	private String diskGb;
	private String vmUuid;
	private String vmdkFile;
	private String status;
	private String bootAble;
	private String nasGb;
	private String pvName;
	private String pvcName;
	private String connectModel;
	private String connectStatus;

	private String nasName;
	private String nasAlias;
	private String nasFileSystemPath;


	private String diskAlias;
	private int sizeGb;
	private String device;
	private String volumeType;
    private String imageId;
	private String imageItemId;

	private String delFlag = "N";
	private String description;
	private String diskCatalogSeq;
	private String diskProductSeq;



}
