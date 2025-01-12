## Automatisation de collecte d'offre d'emplois 

![](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)  
![](https://img.shields.io/badge/BrightData-FF9900?style=for-the-badge)  
![](https://img.shields.io/badge/GmailR-4285F4?style=for-the-badge&logo=gmail&logoColor=white)  
![](https://img.shields.io/badge/Planificateur--Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)  
![](https://img.shields.io/badge/HTML-FF5722?style=for-the-badge&logo=html5&logoColor=white)  
![](https://img.shields.io/badge/Terminal-4D4D4D.svg?logo=WindowsTerminal&logoColor=white)

## Table des matières 

- [Description](#description)
- [Démo](#démo)
- [Structure du projet](#structure)
- [Pré-requis](#pré-requis)
- [Installation](#installation)
- [Technologies](#technologies)
- [Auteurs](#auteurs)


## Description

Le projet Automatisation de la collecte d'offres d'emploi a été développé dans le cadre du cours "Techniques de programmation" du Master Data Science pour l'économie et l'entreprise. Son objectif principal est de fournir une solution complète et automatisée pour collecter, organiser et partager quotidiennement des offres d'emploi issues de la plateforme Glassdoor.

Grâce à des outils avancés comme BrightData pour le scraping et l'API Gmail (intégrée via le package R gmailr) pour l'envoi automatisé des résultats, ce projet propose une expérience fluide, sans intervention manuelle après configuration initiale.

Étapes du projet 

- Web Scraping : Récupération des offres d'emploi en contournant les restrictions imposées par les sites web, grâce à l'API BrightData et ses fonctionnalités avancées (proxys intelligents, déverrouillage automatique).
  
- Nettoyage et structuration des données : Organisation des informations collectées afin qu'elles soient exploitables, avec des colonnes claires (entreprise, titre du poste, localisation, date de publication, et lien de l'offre).
  
- Automatisation : Envoi quotidien des résultats sous forme d'un e-mail structuré contenant un tableau HTML clair et lisible. L'intégration de l'API Gmail (via le package gmailr) permet de générer et d'envoyer ces notifications automatiquement.

## Démo

![](Gif.démo.gif)

## Structure

- Dans [main.R](main.R) vous retrouverez le script principal de scraping et d'envoi automatique des e-mails.
- Dans [gmailr_token.R](sub/fonctions.R) vous retrouverezl e fichier token généré pour authentifier automatiquement l'API Gmail.
- Le fichier [job_data.csv]() Fichier CSV généré contenant les offres d’emploi collectées.
- Dans [gif.démo] (Gif.démo.gif), vous retrouverez le GIF utilisé pour la démonstration dans la documentation.

## Pré-requis

### **Pré-requis**

Avant de commencer, assurez-vous d’avoir les éléments suivants installés et configurés sur votre machine :

1. **R et RStudio** :  
   - Téléchargez et installez [R](https://cran.r-project.org/).  
   - Installez également [RStudio](https://posit.co/download/rstudio/) pour un environnement de développement intégré convivial.

2. **Packages R nécessaires** :  
   Assurez-vous d’avoir les packages suivants installés dans R :
   - `httr` : pour les requêtes HTTP vers l’API BrightData.
   - `rvest` : pour le scraping et le parsing HTML.
   - `gmailr` : pour l’envoi des e-mails via l’API Gmail.  
   - `tidyverse` : pour la manipulation et la structuration des données.  
   Installez-les avec la commande :
   ```R
   install.packages(c("httr", "rvest", "gmailr", "tidyverse"))


