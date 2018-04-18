/*
 * Copyright(C) 2008, NTT AT Co., Ltd.
 * Project: AWGS
 *
 * Notes:
 *  N/A
 *
 * Record of change:
 * Date         Version      	Name       	Content
 * 2009/01/07   1.0		        BaNV     	First create
 * 2008/01/16	1.0				BaNV		Add Log Level       
 */
package com.cwrs.ntk.common;



import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 * Class name : LogWriter <BR>
 * Package : jp.co.ntt_at.awgview.server.common <BR>
 * 
 * Description : Utility function to write log file <BR>
 * Using log4j library <BR>
 * 
 * Usage : LogWriter.getInstance().log_funtion_name Configuration file is
 * log4j.properties, please put it in the same folder of execute able file
 * 
 * @author : AI&T
 * @version : 1.0
 */
public class LogWriter {

	public static String pathConf = "";///AppMainServer.JBOSS_HOME + Constants.LOG4J_CONFIG_FILE;
	
	private static boolean isLoad = false;

	private static final String SNMP_LOG_FILE = "snmp.log.all";

	private static final String DATABASE_LOG_FILE = "db.logfile";

	private static Logger loggerSNMP = Logger.getLogger(SNMP_LOG_FILE);

	private static Logger loggerDatabase = Logger.getLogger(DATABASE_LOG_FILE);

	public static final int SNMP_LOG = 1;

	public static final int DB_LOG = 2;

	/**
	 * The <code>OFF</code> has the highest possible rank and is intended to
	 * turn off logging.
	 */
	public static final Level OFF = Level.OFF;

	/**
	 * The <code>FATAL</code> level designates very severe error events that
	 * will presumably lead the application to abort.
	 */
	public static final Level FATAL = Level.FATAL;

	/**
	 * The <code>ERROR</code> level designates error events that might still
	 * allow the application to continue running.
	 */
	public static final Level ERROR = Level.ERROR;

	/**
	 * The <code>WARN</code> level designates potentially harmful situations.
	 */
	public static final Level WARN = Level.WARN;

	/**
	 * The <code>INFO</code> level designates informational messages that
	 * highlight the progress of the application at coarse-grained level.
	 */

	public static final Level INFO = Level.INFO;

	/**
	 * The <code>DEBUG</code> Level designates fine-grained informational events
	 * that are most useful to debug an application.
	 */
	public static final Level DEBUG = Level.DEBUG;

	/**
	 * The <code>TRACE</code> Level designates finer-grained informational
	 * events than the <code>DEBUG</code level.
	 */

	// public static final Level TRACE = Level.TRACE;
	/**
	 * The <code>ALL</code> has the lowest possible rank and is intended to turn
	 * on all logging.
	 */
	public static final Level ALL = Level.ALL;

	public static Logger getDBLogger() {
		return getInstance(DB_LOG);
	}

	public static Logger getSNMPLogger() {
		return getInstance(SNMP_LOG);
	}

	/**
	 * 
	 * @return Logger instance
	 */
	public static void loadConfigureFile(String path){
		 pathConf = path;
	}
	private static Logger getInstance(int appenderType) {
		if (isLoad) {
			if (appenderType == SNMP_LOG) {
				return loggerSNMP;
			} else {
				return loggerDatabase;
			}
		} else {
			
			
			System.out.println("pathConf: " + pathConf);
			try {
				org.apache.log4j.PropertyConfigurator.configure(pathConf);
			} catch (Exception e) {
				System.err
						.println("Problem writing to log. Not fount property configurator file:"
								+ pathConf);
				System.err.println("Using property configurator file default");
				e.printStackTrace();
			} catch (Error er) {
				System.err
						.println("Problem writing to log. Not fount property configurator file:"
								+ pathConf);
				System.err.println("Using property configurator file default");
				er.printStackTrace();
			}

			isLoad = true;

			if (appenderType == SNMP_LOG) {
				return loggerSNMP;
			} else {
				return loggerDatabase;
			}
		}
	}
}
