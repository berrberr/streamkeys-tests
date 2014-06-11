package com.gshotkeys.tests;

import java.io.File;
import java.util.logging.Level;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.logging.LogEntries;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;

public class MainTest {

	public static String[] urlList = {"http://www.grooveshark.com", "http://www.mixcloud.com"};
	public static void main(String[] args) throws InterruptedException {
		System.setProperty("webdriver.chrome.driver", "./lib/chromedriver");
		ChromeOptions options = new ChromeOptions();
		options.addArguments("start-maximized");
		options.addExtensions(new File("./lib/gshotkeys.crx"));
		DesiredCapabilities capabilities = new DesiredCapabilities();
		
        LoggingPreferences prefs = new LoggingPreferences();
        prefs.enable(LogType.BROWSER, Level.ALL);
        
        capabilities.setCapability(CapabilityType.LOGGING_PREFS, prefs);
		capabilities.setCapability(ChromeOptions.CAPABILITY, options);
		
		ChromeDriver driver = new ChromeDriver(capabilities);
		//WebDriver driver = new ChromeDriver();
		for(String url : urlList) {
			driver.get(url);
			
			
			Thread.sleep(1000);  // Let the user actually see something!
			System.out.println("Printing browser log...");
			LogEntries logEntries = driver.manage().logs().get(LogType.BROWSER);
            for (LogEntry eachEntry : logEntries.getAll()){
                System.out.println(eachEntry.toString());
            }
//			searchBox.sendKeys("ChromeDriver");
//			searchBox.submit();
//			Thread.sleep(5000);  // Let the user actually see something!
		}

		
		driver.quit();
		System.exit(0);
	}

}
