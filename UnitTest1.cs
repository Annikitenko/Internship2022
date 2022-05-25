using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;
using SeleniumExtras.WaitHelpers;
using System;
using System.Threading;

namespace SeleniumHW_Frame
{
    public class Tests
    {
        private IWebDriver _driver;
        private WebDriverWait _wait;
        private string _ProjectName = "ProjectD5";

        [SetUp]
        public void Setup()

        {
            ChromeOptions options = new ChromeOptions();
            options.AddArguments("--start-maximized");
            options.AddArguments("--incognito");
            //options.AddArguments("--auto-open-devtools-for-tabs");

            _driver = new ChromeDriver(options);
            _driver.Navigate().GoToUrl("https://projectplanappweb-stage.azurewebsites.net/login");

            _driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(20);
            _wait = new WebDriverWait(_driver, TimeSpan.FromSeconds(20));

        }
        [TearDown]
        public void TearDown()
        {
            _driver.Close();
            _driver.Quit();
        }
        public void ThreadSleep(int msToWait = 2000)
        {
            Thread.Sleep(msToWait);
        }
        public void WritePassword(string password)
        {
            _wait.Until(ExpectedConditions.ElementIsVisible(By.XPath("//input[@type='password']"))).SendKeys(password);
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

            WaitClick("//div[contains(text(), ' All ')]");

            WaitClick("//input[@class='input-search']");

            _driver.FindElement(By.XPath("//input[@class='input-search']")).SendKeys(_ProjectName);

            WaitClick($"//span[contains(text(), '{_ProjectName}')]");

            string actualResult = _driver.FindElement(By.XPath($"//h4[contains (text(), '{_ProjectName}')]")).Text;

            StringAssert.EndsWith(_ProjectName, actualResult, "Project is not found");
        }

        [Test]
        public void AddLogo()
        {
            SearchInAllProjects();

            ThreadSleep();

            WaitClick("//a[contains (text(),'General')]");

            WaitClick("//a[contains (text(),'Edit')]");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@class='add-image-btn']"))));

            _driver.FindElement(By.XPath("//input[@type='file']")).SendKeys("C:\\Users\\User\\Downloads\\Pudel4.jpg");

            _wait.Until(ExpectedConditions.VisibilityOfAllElementsLocatedBy(By.XPath("//*[@class = 'selected-status-wrapper image ng-star-inserted']")));
            string actualResult = "Image is downloaded";
            Assert.AreEqual("Image is downloaded", actualResult, "Image is not downloaded");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@type = 'submit']")))).Click();

        }

        [Test]
        public void EditLogoLogoLargeSize()
        {
            SearchInAllProjects();

            WaitClick("//a[contains (text(),'General')]");

            WaitClick("//a[contains (text(),'Edit')]");

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@class='add-image-btn']"))));

            _driver.FindElement(By.XPath("//input[@type='file']")).SendKeys("C:\\Users\\User\\Downloads\\pudel_Big_Size.jpg");

            _wait.Until(ExpectedConditions.VisibilityOfAllElementsLocatedBy(By.CssSelector(".error-message")));
            string actualResult = _driver.FindElement(By.CssSelector(".error-message")).Text;
            Assert.AreEqual("Image must not be larger than 5 MB", actualResult);

            _wait.Until(ExpectedConditions.ElementToBeClickable(_driver.FindElement(By.XPath("//button[@type = 'submit']")))).Click();

        }

    }
}