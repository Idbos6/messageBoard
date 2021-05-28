package com.node.bbs.settings.service.impl;

import com.node.bbs.settings.service.HelpThreeEmailService;
import com.node.bbs.utils.Sendmail;
import org.springframework.stereotype.Service;

@Service
public class HelpThreeEmailServiceImpl implements HelpThreeEmailService {
    @Override
    public int SendEmail(String mailTo, String subject, String contents) throws Exception {

        return Sendmail.send_email(mailTo, subject, contents);

    }
}
