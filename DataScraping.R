library(RSelenium)
library(rvest)
library(stringr)

##### Preparing the server
remDr <- remoteDriver(remoteServerAddr = "192.168.99.100", port = 4445L, browser = "chrome")
remDr$open()

##### Navigating to login.
remDr$navigate("https://us.vestiairecollective.com/")
main_webpage <- remDr$findElement("css", "body")
Login_button <- remDr$findElement(using = "css", ".d-lg-none+ .d-lg-block .resetButton")
main_webpage$mouseMoveToLocation(webElement = Login_button) 
main_webpage$click(1)

##### Here I will connecting to profile
##### After connecting we will navigate into to heels section

Email <- remDr$findElement(using = "css", "#user_email")
Email

remDr$navigate("https://us.vestiairecollective.com/women-shoes/heels/")
main_webpage <- remDr$findElement("css", "body")

GoToSleep <- function() {
  Sys.sleep(runif(1,3,4)) 
}

# Initialising  the variables we will collect.
Price <- list()
Likes <- list()
Other_Details <- list() # all other information (will be stored in a vector)

for (i in 1:60)
{
  Temp_individual_item <- remDr$findElement(using = "css", paste0(".col-lg-4:nth-child(",i,") .productSnippet__imageWrapper")) 
  main_webpage$mouseMoveToLocation(webElement = Temp_individual_item) 
  main_webpage$click(1) #Clicking a link to view a specific shoe.
  GoToSleep()
  
  #
  Temp_Other_Details <- remDr$findElements(using = "css", ".descriptionList__block__list li") 
  Temp_Likes <- remDr$findElement(using = "css", ".productTitle__like")
  Temp_Price <- remDr$findElement(using = "css", ".productPrice__price")

  Other_Details[[i]] <- sapply(Temp_Other_Details,function(x){x$getElementText()[[1]]})
  Likes[i] <- Temp_Likes$getElementText()
  Price[i] <- Temp_Price$getElementText()

main_webpage$goBack()  #Returning to the main webpage.
GoToSleep()
print(paste0("scraping product number - ",i))
  }








#### Testing zone
Test <- 
  remDr$findElements(using = "css", "a")
Test$findChildElement()
Test$getElementAttribute('href')
linkList <- sapply(Test,function(x){x$getElementAttribute('href')})
linkList <- as.vector(unlist(linkList))
grepl("^https://us.vestiairecollective.com/women-shoes/heels.+-[[:digit:]]{3,}.shtml",linkList[380])
onlygoodlinks <- 
  linkList[which(grepl("^https://us.vestiairecollective.com/women-shoes/heels.+-[[:digit:]]{3,}.shtml",linkList) == TRUE)]

