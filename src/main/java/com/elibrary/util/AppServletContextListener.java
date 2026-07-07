package com.elibrary.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("UiTM eLibrary Application Starting Up...");
        // Auto-insert dummy data if DB is empty
        DummyDataFactory.insertDummyData();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("UiTM eLibrary Application Shutting Down...");
    }
}
