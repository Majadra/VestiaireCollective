library(RSelenium)
library(rvest)
remDr <- remoteDriver(remoteServerAddr = "192.168.99.100", port = 4445L, browser = "chrome")
remDr$open()


remDr$navigate("https://us.vestiairecollective.com/")
main_webpage <- remDr$findElement("css", "body")
Login_button <- remDr$findElement(using = "css", ".d-lg-none+ .d-lg-block .resetButton")
main_webpage$mouseMoveToLocation(webElement = Login_button) 
main_webpage$click(1)
##### Here I will connect to the profile
##### After connecting we will navigate into to heels section

remDr$navigate("https://us.vestiairecollective.com/women-shoes/heels/")
main_webpage <- remDr$findElement("css", "body")

Online_Since <- list()
Designer <- list()
Model <- list()
Price <- list()
Condition <- list()
Size <- list()
Location <- list()
Reference <- list()
Material <- list()
Color <- list()
load_variable <- function(remDr,variable,address) {
  remDr$findElement(using = "css", as.character(address)) 
}

for (i in 1:60)
{
  Temp_individual_item <- remDr$findElement(using = "css", paste0(".col-lg-4:nth-child(",i,") .productSnippet__imageWrapper")) 
  main_webpage$mouseMoveToLocation(webElement = Temp_individual_item) 
  main_webpage$click(1)
  Sys.sleep(3)
  # All the detailes will be taken from for the individual pages
  Temp_Online_since <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(1)") 
  Temp_Designer <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(5)")
  Temp_Model <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(6)")
  Temp_Price <- remDr$findElement(using = "css", ".productPrice__price")
  Temp_Condition <- remDr$findElement(using = "css", ".descriptionList__block__list span")
  Temp_Size <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(10)")
  try(Temp_Location <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(11)"),silent = T)
  try(Temp_Reference <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(12)"),silent = T)
  Temp_Material <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(8)")
  Temp_Color <- remDr$findElement(using = "css", ".descriptionList__block__list li:nth-child(9)")

  Online_Since[i] <- Temp_Online_since$getElementText()
  Designer[i] <- Temp_Designer$getElementText()
  Model[i] <- Temp_Model$getElementText()
  Price[i] <- Temp_Price$getElementText()
  Condition[i] <- Temp_Size$getElementText()
  Size[i] <- Temp_Size$getElementText()
  try(Location[i] <- Temp_Location$getElementText(),silent = T)
  try(Reference[i] <- Temp_Reference$getElementText(),silent = T)
  Material[i] <- Temp_Material$getElementText()
  Color[i] <- Temp_Color$getElementText()

main_webpage$goBack() 
Sys.sleep(3)
print(paste0("scraping product number - ",i))
  }


### Thats the link .descriptionList__column:nth-child(1) li
Test <- remDr$findElement(using = "css", ".descriptionList__column:nth-child(1) li")
Test$getElementText()
main_webpage$mouseMoveToLocation(webElement = Temp_individual_item) 
main_webpage$click(1)
Test
HeelsPage1 <- main_webpage$getPageSource() %>% .[[1]] %>% read_html()
