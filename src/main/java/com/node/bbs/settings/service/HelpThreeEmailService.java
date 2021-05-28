package com.node.bbs.settings.service;

import org.springframework.stereotype.Service;

@Service
public interface HelpThreeEmailService {

    int SendEmail(String mailTo, String subject, String contents) throws Exception;

}
