package com.ivucenter.cloud.portal.util;

import java.io.File;

public class RepositoryUtils {

	/*
     * This method calculate which sub directory will be used for the give filename
     * Given "fc-HAebxWicwRwccAbAEraah.jpg"
     * it will return "/H/A/e/b/x/"
     */
    public static String getRepositorySubDirectory(String filename) {
    	
        // starts with file separator
        StringBuffer subDir = new StringBuffer(File.separator);
        if (filename == null)  {
            return "";
        }

        // starts from after "fc-" 
        // fc-HAebxWicwRwccAbAEraah.jpg
        int minIndex = 3;         
        int depth = 5;
        
        if (filename.length() < minIndex + depth) {
            depth = filename.length() - minIndex;
        }

        for (int i = minIndex; i < (minIndex + depth); i++) {
            subDir.append(filename.substring(i, i+1));
            subDir.append(File.separator);
        }
        
        return subDir.toString();
    }	
}
