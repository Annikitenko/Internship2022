using NUnit.Framework;
using OpenQA.Selenium;
using Selenium_HW_POM.Extensions;
using SeleniumExtras.WaitHelpers;
using System.Threading;


namespace Selenium_HW_POM
{
    public class StartClass : Base

    {
        private IWebElement logInButton => _driver.FindElement(By.CssSelector("div .button > span"));
        private IWebElement enterEmailPageButton => _driver.FindElement(By.CssSelector("input[name=loginfmt]"));
        private IWebElement nextButton => _driver.FindElement(By.XPath("//input[@type='submit']"));
        private By errorMessage => By.Id("usernameError");
        private By enterPasswordPageButton => By.XPath("//input[@type='password']");
        // private IWebElement nextButton => _driver.FindElement(By.XPath("//input[@type='submit']"));
        // private By errorMessage => By.Id("usernameError");
        private IWebElement projectsBigButton => _driver.FindElement(By.CssSelector("a[routerlink='/projects']"));
        private IWebElement projectsLeftBar => _driver.FindElement(By.Id("projects-tab"));
        private string _projectName;

        private IWebElement dontShowAgain => _driver.FindElement(By.CssSelector("input[name=DontShowAgain]"));



        public void WritePassword(string password)
        {
            _wait.Until(ExpectedConditions.ElementIsVisible(By.XPath("//input[@type='password']"))).SendKeys(password);
        }

        public void ClickOnIt(IWebElement element)
        {
            _wait.Until(ExpectedConditions.ElementToBeClickable(element));
            element.Click();
        }
        public void EnterText(IWebElement element, string text)
        {
            var id = _wait.Until(ExpectedConditions.ElementToBeClickable(element));
            id.Clear();
            id.SendKeys(text);
        }

        public void ThreadSleep(int msToWait = 2000)
        {
            Thread.Sleep(msToWait);
        }
        public void WaitClick(string xpath)
        {
            _wait.Until(ExpectedConditions.ElementToBeClickable(By.XPath(xpath)));
            IWebElement optionNameSelect = _driver.FindElement(By.XPath(xpath));
            optionNameSelect.Click();
        }
        [Test]
        public void SuccesfulLogin()
        {
            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.CssSelector("div .button > span")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.CssSelector("input[name=loginfmt]")))).SendKeys("AUTOMATION.PP@AMDARIS.COM");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//input[@type='submit']")))).Click();

            WritePassword("10704-observe-MODERN-products-STRAIGHT-69112");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//input[@type='submit']")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.CssSelector("input[name=DontShowAgain]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//input[@type='submit']")))).Click();

            _wait.Until(ExpectedConditions.UrlToBe("https://projectplanappweb-stage.azurewebsites.net/dashboard"));

            string actualUrl = _driver.Url;
            Assert.IsTrue(actualUrl == "https://projectplanappweb-stage.azurewebsites.net/dashboard", "Login is not succesful");
        }

        [Test]

        public void GoToProjects_LeftBarTab()
        {
            SuccesfulLogin();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.Id("projects-tab")))).Click();

            _wait.Until(ExpectedConditions.UrlContains("https://projectplanappweb-stage.azurewebsites.net/projects"));
            string actualUrl = _driver.Url;
            StringAssert.StartsWith("https://projectplanappweb-stage.azurewebsites.net/projects", actualUrl, "Projects is not succesful");
        }

        [Test]
        public void GoToProjects_BigTab()
        {
            SuccesfulLogin();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.CssSelector("a[routerlink='/projects']")))).Click();

            _wait.Until(ExpectedConditions.UrlContains("https://projectplanappweb-stage.azurewebsites.net/projects"));
            string actualUrl = _driver.Url;
            StringAssert.StartsWith("https://projectplanappweb-stage.azurewebsites.net/projects", actualUrl, "Login is not succesful"); ;
        }
        [Test]
        public void SearchInAllProjects()
        {
            GoToProjects_BigTab();

            Thread.Sleep(2000);

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//div[contains(text(), ' All ')]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//input[@class='input-search']")))).Click();

            _driver.FindElement(By.XPath("//input[@class='input-search']")).SendKeys(_ProjectName);

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath($"//span[contains(text(), '{_ProjectName}')]")))).Click();

            string actualResult = _driver.FindElement(By.XPath($"//h4[contains (text(), '{_ProjectName}')]")).Text;

            StringAssert.EndsWith(_ProjectName, actualResult, "Project is not found");
        }

        [Test]
        public void AddLogo()
        {
            SearchInAllProjects();

            ThreadSleep();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//a[contains (text(),'General')]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//a[contains (text(),'Edit')]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@class='add-image-btn']"))));

            _driver.FindElement(By.XPath("//input[@type='file']")).SendKeys("C:\\Users\\Amdaris\\HomeWork\\3.16 Page Object Pattern\\Pudel4.jpg");

            _wait.Until(ExpectedConditions.VisibilityOfAllElementsLocatedBy(By.XPath("//*[@class = 'selected-status-wrapper image ng-star-inserted']")));
            string actualResult = "Image is downloaded";
            Assert.AreEqual("Image is downloaded", actualResult, "Image is not downloaded");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@type = 'submit']")))).Click();

        }

        [Test]
        public void EditLogoLogoLargeSize()
        {
            SearchInAllProjects();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//a[contains (text(),'General')]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//a[contains (text(),'Edit')]")))).Click();

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@class='add-image-btn']"))));

            _driver.FindElement(By.XPath("//input[@type='file']")).SendKeys("C:\\Users\\Amdaris\\HomeWork\\3.16 Page Object Pattern\\pudel_Big_Size.jpg");

            _wait.Until(ExpectedConditions.VisibilityOfAllElementsLocatedBy(By.CssSelector(".error-message")));
            string actualResult = _driver.FindElement(By.CssSelector(".error-message")).Text;
            Assert.AreEqual("Image must not be larger than 5 MB", actualResult);

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@type = 'submit']")))).Click();

        }

    }
}