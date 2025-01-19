# Tech Sales Dashboard

## Description

Ce projet est une application Shiny interactive qui offre un tableau de bord des ventes pour une société technologique. Le tableau de bord permet de visualiser, analyser et explorer les données de vente via des graphiques dynamiques et des filtres intuitifs.

L'application est conçue pour être modulaire, maintenable et extensible, en respectant les bonnes pratiques de développement logiciel. Elle utilise le package `renv` pour gérer les dépendances et garantir un environnement reproductible.

---

## Structure du projet

Voici la structure des fichiers et répertoires du projet :

```
.
|-- global.R        # Point d'entrée principal et exécution de l'application
|-- ui.R            # Définition de l'interface utilisateur
|-- server.R        # Logique serveur de l'application
|-- data/           # Contient le fichier Tech Sales Data.xlsx
|-- utils.R         # Fonctions pour générer les graphiques du dashboard
|-- renv.lock       # Fichier de verrouillage pour renv
|-- renv/           # Dossier renv pour gérer les dépendances
```

---

## Fonctionnalités principales

- **Filtres dynamiques** : Filtrage interactif des ventes par magasin et catégorie de produits.
- **Visualisations avancées** : Graphiques interactifs générés avec `ggplot2` et `plotly`.
- **Chargement des données** : Intégration directe du fichier Excel pour extraire et transformer les données.
- **Modularité** : Séparation claire entre l’interface utilisateur, la logique serveur et les fonctions utilitaires.
- **Reproductibilité** : Gestion des dépendances avec le package `renv` pour garantir un environnement de développement stable.

---

## Installation

1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/<ton_utilisateur>/<nom_du_dépôt>.git
   cd <nom_du_dépôt>
   ```

2. **Restaurez l'environnement renv** :
   ```bash
   R -e "renv::restore()"
   ```

3. **Lancez l'application** :
   ```bash
   Rscript global.R
   ```

---

## Dépendances

Les principaux packages utilisés dans ce projet sont :

- `shiny` : Framework principal pour la création de l'application.
- `shinydashboard` : Structure du tableau de bord.
- `dplyr` : Manipulation des données.
- `ggplot2` : Visualisations statiques.
- `plotly` : Graphiques interactifs.
- `readxl` : Lecture des fichiers Excel.
- `shinyWidgets` : Amélioration des composants interactifs.

Tous les packages sont gérés et verrouillés via `renv`.

---


## Auteur

[Josué AFOUDA](https://www.linkedin.com/in/josu%C3%A9-afouda)

Regardez la vidéo de ce projet pour de plus amples explications : https://youtu.be/BOIjqRVSSD0

---

