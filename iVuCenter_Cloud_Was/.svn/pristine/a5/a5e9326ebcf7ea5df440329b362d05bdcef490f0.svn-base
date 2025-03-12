package com.ivucenter.cloud.api.common.utils;


import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.ivucenter.cloud.api.openstack.object.Alarm;
import com.ivucenter.cloud.api.openstack.object.CustomVolume;
import com.ivucenter.cloud.api.openstack.object.Measure;
import com.ivucenter.cloud.api.openstack.object.OpenStackJsonObject;
import com.ivucenter.cloud.api.openstack.object.OpenStackMetricData;
import com.ivucenter.cloud.api.vRealize.object.vraBlockDevice;
import com.ivucenter.cloud.api.vRealize.object.vraCatalogObject;
import com.ivucenter.cloud.api.vRealize.object.vraComputeNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraDataStoreContent;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworkVsphere;
import com.ivucenter.cloud.api.vRealize.object.vraFabricNetworks;
import com.ivucenter.cloud.api.vRealize.object.vraFlavor;
import com.ivucenter.cloud.api.vRealize.object.vraHostContent;
import com.ivucenter.cloud.api.vRealize.object.vraJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraMachine;
import com.ivucenter.cloud.api.vRealize.object.vraMachineDisks;
import com.ivucenter.cloud.api.vRealize.object.vraNetwork;
import com.ivucenter.cloud.api.vRealize.object.vraNetworkInterfaces;
import com.ivucenter.cloud.api.vRealize.object.vraProjectObject;
import com.ivucenter.cloud.api.vRealize.object.vraServer;
import com.ivucenter.cloud.api.vRealize.object.vraServerRequest;
import com.ivucenter.cloud.api.vRealize.object.vraTokenJsonObject;
import com.ivucenter.cloud.api.vRealize.object.vraZone;
import com.ivucenter.cloud.api.vmware.object.VmDataStoreObject;
import com.ivucenter.cloud.api.vmware.object.VmDisks;
import com.ivucenter.cloud.api.vmware.object.VmWareJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareDetailsItemJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareLibrariesJsonObject;
import com.ivucenter.cloud.api.vmware.object.VmwareTokenJsonObject;

public class JsonUtils {


    private static final Logger logger = LoggerFactory.getLogger(JsonUtils.class);


//	public static String getPathValue(String payLoad, String path) {
//		String result = "";
//	    try {
//			ObjectMapper mapper = new ObjectMapper();
//			JsonNode rootNode = mapper.readTree(payLoad);
//
//			JsonNode resultNode = rootNode.at(path);
//
//			result = resultNode.asText();
//		} catch (Exception e) {
//		}
//		return result;
//	}

	public static String getJsonSimpleString(String jsonString) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			result = mapper.readTree(jsonString).toString();
		} catch (IOException e) {
            logger.error("JSON 처리 중 오류 발생");
		}
		return result;
	}

	public static String getJsonFormatString(String jsonString) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(mapper.readTree(jsonString));
		} catch (IOException e) {
			return "";
		}
		return result;
	}

	public static String getJsonSimpleString(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
			result = mapper.writeValueAsString(obj);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return result;
	}

	public static String getJsonFormatString(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
			result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return result;
	}

	public static String alwaysJsonFormatString(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		String result = null;
		try {
			result = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return result;
	}


	public static OpenStackJsonObject getJsonObject(String jsonString) {
		OpenStackJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, OpenStackJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생" + e.getMessage(), e);
		}
		return obj;
	}

	public static vraJsonObject vraGetJsonObject(String jsonString) {
		vraJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraFlavor vraGetFlavorObject(String jsonString) {
		vraFlavor obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraFlavor.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraCatalogObject vraGetCatalogObject(String jsonString) {
		vraCatalogObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraCatalogObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static VmWareJsonObject getVmWareJsonObject(String jsonString) {
		VmWareJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmWareJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static VmDataStoreObject getVmWareDataStoreObject(String jsonString) {
		VmDataStoreObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmDataStoreObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static List<CustomVolume> getJsonCustomVolumeDatas(String jsonString) {
		List<CustomVolume> obj = new LinkedList<CustomVolume>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, mapper.getTypeFactory().constructCollectionType(List.class, CustomVolume.class));
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static List<OpenStackMetricData> getJsonMetricDatas(String jsonString) {
		List<OpenStackMetricData> obj = new LinkedList<OpenStackMetricData>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, mapper.getTypeFactory().constructCollectionType(List.class, OpenStackMetricData.class));
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static OpenStackMetricData getJsonMetricData(String jsonString) {
		OpenStackMetricData obj = new OpenStackMetricData();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, OpenStackMetricData.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static List<Measure> getJsonMeasuresData(String jsonString) {
		List<Measure> obj = new LinkedList<Measure>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, mapper.getTypeFactory().constructCollectionType(List.class, Measure.class));
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static List<Alarm> getJsonAlarmDatas(String jsonString) {
		List<Alarm> obj = new LinkedList<Alarm>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, mapper.getTypeFactory().constructCollectionType(List.class, Alarm.class));
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static Alarm getJsonAlarmData(String jsonString) {
		Alarm obj = new Alarm();
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, Alarm.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

//	public static List<Measure> getJsonMeasuresData(String jsonString) {
//		List<Measure> obj = new LinkedList<Measure>();
//		ObjectMapper mapper = new ObjectMapper();
//		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
//		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
//
//		try {
//			obj = mapper.readValue(jsonString, mapper.getTypeFactory().constructCollectionType(List.class, Measure.class));
//		} catch (Exception e) {
//			logger.error("JSON 처리 중 오류 발생");
//		}
//		return obj;
//	}

	public static void sleep(long time) {
		try { Thread.sleep(time); } catch (InterruptedException e) {}
	}

	public static VmwareTokenJsonObject getJsonObjectVmware(String jsonString) {
		VmwareTokenJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmwareTokenJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraTokenJsonObject getJsonObjectVra(String jsonString) {
		vraTokenJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraTokenJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraNetwork getVraNetworkJsonObject(String jsonString) {
		vraNetwork obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraNetwork.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraNetworkInterfaces getVraNetworkInterfacesJsonObject(String jsonString) {
		vraNetworkInterfaces obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraNetworkInterfaces.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraFabricNetworks getVraFabricNetworksJsonObject(String jsonString) {
		vraFabricNetworks obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraFabricNetworks.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraFabricNetworkVsphere getVraFabricNetworksVsphereJsonObject(String jsonString) {
		vraFabricNetworkVsphere obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraFabricNetworkVsphere.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraComputeNetwork getVraComputeNetworkJsonObject(String jsonString) {
		vraComputeNetwork obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraComputeNetwork.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static VmwareLibrariesJsonObject getJsonLibrariesObject(String jsonString) {
		VmwareLibrariesJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmwareLibrariesJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static VmwareDetailsItemJsonObject getJsonDetailsItemObject(String jsonString) {
		VmwareDetailsItemJsonObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmwareDetailsItemJsonObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}


	public static VmDisks getJsonGetDiskObject(String jsonString) {
		VmDisks obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, VmDisks.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraServer getJsonVraServerObject(String jsonString) {
		vraServer obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraServer.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraZone getJsonVraZoneObject(String jsonString) {
		vraZone obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraZone.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraServerRequest getJsonVraServerRequestObject(String jsonString) {
		vraServerRequest obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraServerRequest.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraHostContent getJsonVraHostObject(String jsonString) {
		vraHostContent obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraHostContent.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraMachineDisks getJsonVraMachineDiskObject(String jsonString) {
		vraMachineDisks obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraMachineDisks.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraBlockDevice getJsonVrablockDeviceObject(String jsonString) {
		vraBlockDevice obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraBlockDevice.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraDataStoreContent getJsonVraDataStoreObject(String jsonString) {
		vraDataStoreContent obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraDataStoreContent.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}
	public static vraProjectObject getJsonVraProjectsObject(String jsonString) {
		vraProjectObject obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraProjectObject.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

	public static vraMachine getJsonVraMachineObject(String jsonString) {
		vraMachine obj = null;
		ObjectMapper mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		try {
			obj = mapper.readValue(jsonString, vraMachine.class);
		} catch (IOException e) {
			logger.error("JSON 처리 중 오류 발생");
		}
		return obj;
	}

}
