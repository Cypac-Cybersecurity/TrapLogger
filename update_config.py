import json
import os
import sys

def update_config():
    config_file = '/root/.opencanary.conf'
    smtp_host = os.getenv('SMTP_HOST')
    
    if smtp_host:
        with open(config_file, 'r') as file:
            config = json.load(file)

        smtp_handler = {
            "class": "logging.handlers.SMTPHandler",
            "mailhost": [smtp_host, int(os.getenv('SMTP_PORT', 587))],
            "fromaddr": os.getenv('EMAIL_FROM', 'noreply@yourdomain.com'),
            "toaddrs" : [os.getenv('EMAIL_TO', 'youraddress@gmail.com')],
            "subject" : "OpenCanary Alert",
            "credentials" : [os.getenv('SMTP_USERNAME', 'youraddress'), os.getenv('SMTP_PASSWORD', 'password')],
            "secure" : []
        }

        if "handlers" in config["logger"]["kwargs"]:
            config["logger"]["kwargs"]["handlers"]["SMTP"] = smtp_handler

        with open(config_file, 'w') as file:
            json.dump(config, file, indent=4)

if __name__ == '__main__':
    update_config()
    os.execvp("opencanaryd", ["opencanaryd"] + sys.argv[1:])
