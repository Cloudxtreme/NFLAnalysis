library(XML)

# Initializing our empty dataframes
weeklystats = as.data.frame(matrix(ncol = 14))

# Naming columns
names(weeklystats) = c("Week", "Day", "Date", "Blank", "Win.Team", "At", "Lose.Team", 
                       "Points.Win", "Points.Lose", "YardsGained.Win", "Turnovers.Win", "YardsGained.Lose", 
                       "Turnovers.Lose", "Year")  

URL1 = "http://www.pro-football-reference.com/teams/"
URL2 = "http://www.pro-football-reference.com/years/"

# Get list of team abbreviations from standings
teamTable = readHTMLTable("http://www.pro-football-reference.com/");
teams <- teamTable[[1]]$V1
cutOut <- c("AFC","NFC","North","South","East","West")
teams <- strtrim(teams[!(teams %in% cutOut)],3)

# Set up our data structures
records <- list()
recordFrame <- data.frame()

# List of data frames
# Get each team's record
for(year in 2002:2013) {
  
  for(team in teams) {
    rbind(recordFrame, c(team, getRecord(team, year))
  }

  names(recordFrame) <- c("Team", "Wins", "Losses", "Ties")
  records[[year-2001]] <- recordFrame
  recordFrame <- data.frame()
}

# Calculate strength of schedule for each team
# SoS = (total wins against + ,5 * ties) / 256

# Calculate strength of victory for each team
# SoV = (total wins by losing teams against .5 * ties) / (16 * wins) 

# Extract number of 
#   {Superbowl wins, Superbowl appearance, playoff win %, playoff appearances,
#    playoff games won, playoff seeding, and player-games lost to injuries}
# for each team



#### Our workhorse functions ####

# Returns the Win-Loss-Tie record for this team and year as a list of integers
# 
# team    the team for which to get the record
# year    the year for which to get the record
getRecord = function(team, year) {
  
  for (i in 2002:2013) {
    
    URL = paste(URLpart1, as.character(i), URLpart3, sep = "")
    
    tablefromURL = readHTMLTable(URL)
    
    table = tablefromURL[[1]]
    
    names(table) = c("Week", "Day", "Date", "Blank", "Win.Team", "At", "Lose.Team", 
                     "Points.Win", "Points.Lose", "YardsGained.Win", "Turnovers.Win", 
                     "YardsGained.Lose", "Turnovers.Lose")
    
    # Inserting a value for the year
    table$Year = i   
    
    # Appending happening here
    weeklystats = rbind(table, weeklystats)  
    
  }
  
  return(weeklystats)
}

# Returns the opponents for this team for this year as a list of characters
#
# team    the team for which to get the opponents
# year    the year for which to get the opponents
getSchedule = function(team, year) {
  
  
}

# Returns the number of wins for this team during this year as a single integer
#
# team    the team for which to get the number of wins
# year    the year for which to get the number of wins
getWins = function(team, year) {
  
}


weeklystats = getData(URLpart1, URLpart3)  # Calling on our workhorse to do its job and saving the raw data results in weeklystats
save(weeklystats, file = "rawweeklystats.rda")