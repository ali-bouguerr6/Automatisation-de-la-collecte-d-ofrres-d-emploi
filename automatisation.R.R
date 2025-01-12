library(httr)
library(rvest)

# URL de l'API BrightData
api_url <- "https://api.brightdata.com/request"

# Token d'autorisation (API Token)
api_token <- "45f2f355d6ddd1f6fa6ec92f63e8f569a0e1855cc40975d377524f5944ceae37"

# Corps de la requête (payload)
payload <- list(
  zone = "web_unlocker3",
  url = "https://www.glassdoor.fr/Emploi/strasbourg-67-france-data-analyst-emplois-SRCH_IL.0,20_IC2832209_KO21,33.htm",
  format = "raw"
)

# Requête POST vers l'API BrightData
response <- POST(
  url = api_url,
  add_headers(
    `Content-Type` = "application/json",
    `Authorization` = paste("Bearer", api_token)
  ),
  body = payload,
  encode = "json"
)

# Vérification de la réponse et extraction du contenu
if (http_status(response)$category == "Success") {
  # Extraire le HTML brut
  html_page <- content(response, as = "text")
  
  # Sauvegarder dans un fichier pour inspection
  writeLines(html_page, "glassdoor_page.html")
  cat("HTML sauvegardé dans 'glassdoor_page.html'.\n")
} else {
  # En cas d'erreur
  cat("Erreur HTTP :", http_status(response)$reason, "\n")
  print(content(response, as = "text"))
}

html_page

parsed_html <- read_html(html_page)


# Extraire le nom du poste
job_titles <- parsed_html %>%
  html_elements(".JobCard_jobTitle__GLyJ1") %>%
  html_text(trim = TRUE)

job_titles

# Extraire les liens des offres
job_links <- parsed_html %>%
  html_elements(".JobCard_jobTitle__GLyJ1") %>%
  html_attr("href") %>%
  paste0("https://www.glassdoor.fr", .)  # Ajouter le domaine pour les liens relatifs


company_names <- parsed_html %>%
  html_elements(".EmployerProfile_compactEmployerName__9MGcV") %>%  
  html_text(trim = TRUE)


job_days <- parsed_html %>%
  html_elements(".JobCard_listingAge__jJsuc") %>%  # Sélecteur CSS pour les jours
  html_text(trim = TRUE)


locations <- parsed_html %>%
  html_elements("[data-test='emp-location']") %>%  # Sélecteur basé sur l'attribut
  html_text(trim = TRUE)


# Trouver la longueur maximale parmi les colonnes
max_length <- max(length(company_names), length(job_days), length(job_links), length(job_titles), length(locations))

# Compléter les colonnes plus courtes avec NA
company_names <- c(company_names, rep(NA, max_length - length(company_names)))
job_days <- c(job_days, rep(NA, max_length - length(job_days)))
job_links <- c(job_links, rep(NA, max_length - length(job_links)))
job_titles <- c(job_titles, rep(NA, max_length - length(job_titles)))
locations <- c(locations, rep(NA, max_length - length(locations)))

# Créer un data frame
job_data <- data.frame(
  Company = company_names,
  Job_Title = job_titles,
  Location = locations,
  Job_Days = job_days,
  Job_Link = job_links,
  stringsAsFactors = FALSE
)

# Afficher le tableau
job_data


# Sauvegarder dans un fichier CSV
write.csv(job_data, "job_data_complete.csv", row.names = FALSE)
cat("Tableau sauvegardé dans 'job_data_complete.csv'.\n")


#test avec gmailr


library(gmailr)

# Charger les identifiants
gm_auth_configure(path = "C:/Users/alibo/Downloads/client_secret_689519034921-a5cmdd2olrqi0tk0lqr683ssqq541kfh.apps.googleusercontent.com.json")
gm_auth(cache = "gmailr_token")

# Authentifie-toi en demandant explicitement les permissions nécessaires
gm_auth(scopes = c(
  "https://www.googleapis.com/auth/gmail.send",
  "https://www.googleapis.com/auth/gmail.compose",
  "https://www.googleapis.com/auth/gmail.modify"
))
gm_auth(cache = "C:/Users/alibo/OneDrive/Documents/util de Scraping pour la Recherche d'Emploi/gmailr_token/c5d42487fed1d653b5b2889d5d8a4cd4_alibouguerra38@gmail.com")


# Charger les données collectées
job_data <- read.csv("job_data_complete.csv")  # Remplace avec le chemin de ton fichier CSV

# Générer un tableau HTML des offres
job_table <- paste0(
  "<table border='1' style='border-collapse: collapse; width: 100%;'>",
  "<tr><th>Company</th><th>Job Title</th><th>Location</th><th>Job Days</th><th>Job Link</th></tr>",
  paste0(
    apply(job_data, 1, function(row) {
      paste0("<tr><td>", paste(row, collapse = "</td><td>"), "</td></tr>")
    }),
    collapse = ""
  ),
  "</table>"
)

# Créer l'e-mail
email <- gm_mime() %>%
  gm_to("alibouguerra38@gmail.com ") %>%
  gm_from("alibouguerra38@gmail.com") %>%
  gm_subject("Résumé des offres d'emploi collectées") %>%
  gm_html_body(paste0(
    "Bonjour,<br><br>",
    "Voici les offres d'emploi collectées aujourd'hui :<br><br>",
    job_table,
    "<br><br>Bonne journée,<br>L'équipe."
  ))

# Envoyer l'e-mail
gm_send_message(email)

cat("E-mail envoyé avec succès !\n")


