package com.ivucenter.cloud.portal.bss.batch;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.Trigger.TriggerState;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/batch")
public class SchedulerController {
	
	@Autowired
    private SchedulerService schedulerService;


	/***************************************************
     * stopScheduler : 스케쥴러의 동작을 중지한다.
     ***************************************************/
	@RequestMapping(value="/stopScheduler.do")
	public void stopScheduler(HttpServletRequest request, HttpServletResponse response )throws Exception{
		//String jobGrp = request.getParameter("jobGrp");

		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();

		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		scheduler.pauseAll();
		
		log.debug("====> Scheduler stoped...");
	}
	

    /***************************************************
     * resumeScheduler : 중지된 스케쥴러의 동작을 재개한다.
     ***************************************************/
	@RequestMapping(value="/resumeScheduler.do")
	public void resumeScheduler(HttpServletRequest request, HttpServletResponse response)throws Exception{
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		scheduler.resumeAll();
		
		log.debug("====> Scheduler resumeed...");
	}
	
    /***************************************************
     * schedulerList : 스케쥴러에 등록된 JOB들의 정보를 확인한다.
     ***************************************************/
    @RequestMapping(value="/schedulerList.do", method=RequestMethod.GET)
	public ResponseEntity<Object> schedulerList(HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		log.debug("==> /admin/schedulerList.do");

		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();

		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		String schedName = scheduler.getSchedulerName();
		
		CustomSchedulerVO paramSchedulerVO = new CustomSchedulerVO();
		paramSchedulerVO.setSchedName(schedName);
		
		String res = schedulerService.list(paramSchedulerVO);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	
    
    /***************************************************
     * jobDetail : 스케쥴러에 등록된 JOB의 상세정보를 확인한다.
     ***************************************************/
    @RequestMapping(value="/jobDetail.do")
	public ResponseEntity<Object> jobDetail(HttpServletRequest request, HttpServletResponse response, CustomSchedulerVO req ) throws Exception{ 
		log.debug("==> jobDetail.do / jobName :" + request.getParameter("jobName"));
		
		CustomSchedulerVO res = schedulerService.detail(req);
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}

	
    /***************************************************
     * registerJob : 스케쥴러에 JOB을 신규로 등록한다.
     ***************************************************/
	@RequestMapping(value="/registerJob.do")
	public ResponseEntity<Object> registerJob(HttpServletRequest req, HttpServletResponse resp, CustomSchedulerVO vo )throws Exception{
		String jobName = req.getParameter("jobName");
		String jobClassName = req.getParameter("jobClassName");
		String cronSchedule = req.getParameter("cronExpression");
//		String jobName = "helloJob"; 
//		String jobClassName = "com.ivu.batch.hello.JobLauncherDetails";
//		String cronSchedule = "0/5 * * * * ?";

		log.debug("====> Scheduler registerJob...");
		
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		@SuppressWarnings("unchecked")
		Class<? extends Job> jobClass = (Class<? extends Job>)(Class.forName(jobClassName));
		JobDetail jobDetail = JobBuilder
        		.newJob(jobClass)
        		.withIdentity(jobName, Scheduler.DEFAULT_GROUP)
        		.build();
        
        String triggerName = "cronTr_" + jobName;
        Trigger trigger = TriggerBuilder
	            .newTrigger()
	    		.withIdentity(triggerName, Scheduler.DEFAULT_GROUP)
	    		.withSchedule(
	    			CronScheduleBuilder.cronSchedule(cronSchedule))
	    		.build();

	    if (scheduler.checkExists(jobDetail.getKey())) {
	    	scheduler.deleteJob(jobDetail.getKey());
	    }

	    if (scheduler.checkExists(trigger.getKey())) {
	    	scheduler.unscheduleJob(trigger.getKey());
	    }
	    
        scheduler.scheduleJob(jobDetail, trigger);
		log.debug("====> Job is registered...");
		
		String res = "1";
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}


    /***************************************************
     * deleteJob : 스케쥴러에 등록된 JOB을 삭제한다.
     ***************************************************/
	@RequestMapping(value="/deleteJob.do")
	public ResponseEntity<Object> deleteJob(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String jobName = request.getParameter("jobName");
//		String jobName = "helloJob"; 

		log.debug("====> Scheduler deleteJob...");
		
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		JobKey jobKey = new JobKey(jobName, Scheduler.DEFAULT_GROUP);	
	    if (scheduler.checkExists(jobKey)) {
			scheduler.deleteJob(jobKey);	
			log.debug("Job is deleted..");
		}

        String triggerName = "cronTr_" + jobName;
		TriggerKey triggerKey = new TriggerKey(triggerName, Scheduler.DEFAULT_GROUP);
		TriggerState trState = scheduler.getTriggerState(triggerKey);
		
		log.debug("TriggerState:" + trState);
		
		String res = "1";
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	

    /***************************************************
     * stopJob : 기동중인 JOB을 중지한다.
     ***************************************************/
	@RequestMapping(value="/stopJob.do")
	public ResponseEntity<Object> stopJob(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String jobName = request.getParameter("jobName");
//		String jobName = "helloJob"; 

		log.debug("====> Scheduler stopJob...");
		
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		JobKey jobKey = new JobKey(jobName, Scheduler.DEFAULT_GROUP);	
	    if (scheduler.checkExists(jobKey)) {
			scheduler.pauseJob(jobKey);
			log.debug("Job is paused..");
		}

        String triggerName = "cronTr_" + jobName;
		TriggerKey triggerKey = new TriggerKey(triggerName, Scheduler.DEFAULT_GROUP);
		TriggerState trState = scheduler.getTriggerState(triggerKey);
		
		log.debug("TriggerState:" + trState);
		String res = "1";
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	

    /***************************************************
     * resumeJob : 중지 중인 JOB을 재 시작한다.
     ***************************************************/
	@RequestMapping(value="/resumeJob.do")
	public ResponseEntity<Object> resumeJob(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String jobName = request.getParameter("jobName");
//		String jobName = "helloJob"; 

		log.debug("====> Scheduler resumeJob...");
		
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		
		JobKey jobKey = new JobKey(jobName, Scheduler.DEFAULT_GROUP);	
	    if (scheduler.checkExists(jobKey)) {
			scheduler.resumeJob(jobKey);
			log.debug("Job is resumed..");
		}

        String triggerName = "cronTr_" + jobName;
		TriggerKey triggerKey = new TriggerKey(triggerName, Scheduler.DEFAULT_GROUP);
		TriggerState trState = scheduler.getTriggerState(triggerKey);
		
		log.debug("TriggerState:" + trState);
		
		String res = "1";
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
	

    /***************************************************
     * reScheduleJob : JOB의 수행 주기를 변경한다.
     ***************************************************/
	@RequestMapping(value="/reScheduleJob.do")
	public ResponseEntity<Object> reScheduleJob(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String jobName = request.getParameter("jobName");
		String cronSchedule = request.getParameter("cronExpression");
//		String jobName = "helloJob"; 
//		String jobClassName = "com.ivu.batch.hello.JobLauncherDetails";
//		String cronSchedule = "0/10 * * * * ?";

		log.debug("====> Scheduler resumeJob...");
		
		SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		Scheduler scheduler = schedulerFactory.getScheduler();
		log.debug("SchedulerInstanceId :" + scheduler.getSchedulerInstanceId() + 
				", SchedulerName :" + scheduler.getSchedulerName());
		

        String triggerName = "cronTr_" + jobName;
		Trigger oldTrigger = scheduler.getTrigger(new TriggerKey(triggerName, Scheduler.DEFAULT_GROUP));
		
		@SuppressWarnings("rawtypes")
		TriggerBuilder triggerBuilder = oldTrigger.getTriggerBuilder();
		@SuppressWarnings("static-access")
		CronTrigger newTrigger = (CronTrigger)triggerBuilder
				.newTrigger()
	    		.withIdentity(triggerName, Scheduler.DEFAULT_GROUP)
	    		.withSchedule(
		    			CronScheduleBuilder.cronSchedule(cronSchedule))
	    		.startNow()
	    		.build();

		TriggerState trState = scheduler.getTriggerState(newTrigger.getKey());
		log.debug("trState: " + trState);
		

        scheduler.rescheduleJob(oldTrigger.getKey(), newTrigger);
        
		log.debug("====> Job is rescheduled...");
		String res="1";
		
		return new ResponseEntity<Object>(res, HttpStatus.OK);
	}
}
