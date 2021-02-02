exports.config = {

    framework: 'jasmine',
    specs: ['spec.js'],
    capabilities: {
        'browserName': 'chrome',
        chromeOptions: {
            args: [ "--headless", "--disable-gpu", "--disable-dev-shm-usage", "--no-sandbox" , "--window-size=1440,960", 'disable-infobars']
        },
        directConnect: true 
    }

};