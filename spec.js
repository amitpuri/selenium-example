const { browser } = require("protractor");

describe('Protractor Demo App', function() {

    var firstNumber = element(by.model('first'));

    beforeEach(function() {
        browser.waitForAngularEnabled(false);
        browser.get('http://juliemr.github.io/protractor-demo/');
    });

    it('should have a title', function() {  
      expect(browser.getTitle()).toEqual('Super Calculator');
    });

    it('should start out with an empty memory', function () {
        var memory =
            element.all(by.repeater('result in memory'));
  
        expect(memory.count()).toEqual(0);
    }); 
    
    it('should read the value from an input', function() {
        firstNumber.sendKeys(1);
        expect(firstNumber.getAttribute('value')).toEqual('1');
    });
});