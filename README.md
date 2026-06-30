# 🎓 AURA — Réussis ton BAC avec confiance.

<p align="center">
  <strong>Application mobile de préparation au BAC en Côte d'Ivoire — 100% hors ligne</strong>
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.19-02569B?logo=flutter&logoColor=white">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.2-0175C2?logo=dart&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/license-Private-lightgrey">
  <img alt="Build" src="https://img.shields.io/badge/build-passing-22C55E">
</p>

---

## 📖 Sommaire

- [Présentation](#-présentation)
- [Fonctionnalités](#-fonctionnalités)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Lancement](#-lancement)
- [Structure du projet](#-structure-du-projet)
- [Dépendances](#-dépendances)
- [Build & Déploiement](#-build--déploiement)
- [Contribuer](#-contribuer)

---

## 🎯 Présentation

**AURA** est une application mobile Flutter conçue pour accompagner les élèves de Côte d'Ivoire dans leur préparation au **Baccalauréat**, toutes séries confondues (A1, A2, C, D, G1, G2, F1, F2, F3).

L'application fonctionne **entièrement hors ligne** : aucune connexion internet n'est requise après l'installation. Toutes les données (cours, exercices, quiz, sujets BAC) sont stockées localement grâce à **Hive**, garantissant rapidité et disponibilité permanente, y compris en zone à faible connectivité.

---

## ✨ Fonctionnalités

### 🏠 Accueil
- Tableau de bord personnalisé avec statistiques en temps réel
- Citation motivante renouvelée chaque jour
- Accès rapide aux séries populaires
- Derniers cours consultés

### 📚 Contenu pédagogique
- **9 séries du BAC** : A1, A2, C, D, G1, G2, F1, F2, F3
- **12 matières** : Français, Philosophie, Mathématiques, Histoire-Géographie, SVT, Physique-Chimie, Anglais, Espagnol, Allemand, Économie, Comptabilité, Informatique
- Pour chaque matière : cours détaillés, résumés, exercices corrigés, sujets BAC avec corrigés, conseils pratiques

### 🧠 Quiz interactifs
- QCM avec retour immédiat et explications pédagogiques
- Chronomètre par question
- Système de score et de points
- Historique complet des tentatives
- Filtrage par niveau de difficulté (Facile, Moyen, Difficile)

### 📊 Statistiques
- Moyenne générale et par matière
- Graphique d'évolution des scores
- Temps de travail cumulé
- Progression visuelle par matière

### ⭐ Favoris
- Sauvegarde de cours, exercices et sujets BAC
- Accès rapide depuis l'onglet dédié

### 🔍 Recherche
- Recherche instantanée sur l'ensemble du contenu

### ⚙️ Paramètres
- Mode clair / sombre
- Réinitialisation des données
- Informations sur l'application

---

## 🏗 Architecture

AURA suit une architecture **Clean Architecture** combinée au pattern **MVVM** et au **Repository Pattern**, garantissant un code maintenable, testable et évolutif.

```
Presentation Layer (UI + Riverpod Providers)
        ↓
Domain Layer (Entities, Use Cases)
        ↓
Data Layer (Repositories, Models, Hive)
```

- **State Management** : Riverpod (StateNotifier + Provider)
- **Navigation** : go_router (déclaratif, type-safe)
- **Stockage local** : Hive (NoSQL, rapide, multiplateforme)
- **UI** : Material Design 3 avec thème personnalisé

---

## 📦 Installation

### Prérequis

- [Flutter SDK](https://flutter.dev/docs/get-started/install) ≥ 3.19.0
- [Dart SDK](https://dart.dev/get-dart) ≥ 3.2.0
- Android Studio ou VS Code avec les extensions Flutter/Dart
- Un appareil Android (≥ API 21) ou un émulateur

### Étapes

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/hassanoft/AURA-BAC.git
   cd AURA-BAC
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Vérifier l'installation**
   ```bash
   flutter doctor
   ```

---

## 🚀 Lancement

### Mode développement

```bash
flutter run
```

### Lancer sur un appareil spécifique

```bash
flutter devices          # lister les appareils disponibles
flutter run -d <device_id>
```

### Lancer les tests

```bash
flutter test
```

### Analyser le code (lint)

```bash
flutter analyze
```

---

## 📁 Structure du projet

```
aura_bac/
├── android/                     # Configuration Android native
├── lib/
│   ├── core/
│   │   ├── constants/           # Couleurs, constantes globales
│   │   ├── router/              # Configuration go_router
│   │   └── theme/               # Thème Material 3 (clair/sombre)
│   ├── data/
│   │   ├── datasources/         # Service de génération des données d'exemple
│   │   ├── models/               # Modèles Hive (Series, Subject, Course, Quiz...)
│   │   └── repositories/        # Accès aux données (Repository Pattern)
│   ├── presentation/
│   │   ├── providers/           # Providers Riverpod (state management)
│   │   ├── screens/              # Écrans de l'application
│   │   │   ├── home/
│   │   │   ├── series/
│   │   │   ├── subjects/
│   │   │   ├── quiz/
│   │   │   ├── stats/
│   │   │   ├── favorites/
│   │   │   ├── search/
│   │   │   └── settings/
│   │   └── widgets/              # Widgets réutilisables
│   ├── app.dart                  # Widget racine MaterialApp
│   └── main.dart                 # Point d'entrée de l'application
├── test/                         # Tests unitaires
├── .github/workflows/            # CI/CD GitHub Actions
├── analysis_options.yaml         # Règles de lint
├── pubspec.yaml                  # Dépendances et métadonnées
└── README.md
```

---

## 📚 Dépendances

| Package | Usage |
|---|---|
| `flutter_riverpod` | Gestion d'état réactive |
| `go_router` | Navigation déclarative |
| `hive` / `hive_flutter` | Base de données locale NoSQL |
| `google_fonts` | Typographie (Poppins) |
| `fl_chart` | Graphiques de progression |
| `pdf` / `printing` | Export PDF des sujets BAC |
| `flutter_animate` | Animations fluides |
| `percent_indicator` | Barres et cercles de progression |
| `iconsax` | Icônes modernes |
| `shared_preferences` | Préférences utilisateur simples |

Voir `pubspec.yaml` pour la liste complète et les versions exactes.

---

## 🏭 Build & Déploiement

### Build APK (débogage)

```bash
flutter build apk --debug
```

### Build APK (production, optimisé par architecture)

```bash
flutter build apk --release --split-per-abi
```

Les APK générés se trouvent dans `build/app/outputs/flutter-apk/`.

### CI/CD automatique

Le projet est livré avec un workflow **GitHub Actions** (`.github/workflows/build.yml`) qui :
- Compile automatiquement l'APK à chaque push
- Exécute les tests et l'analyse de code
- Publie une release GitHub avec les APK lors d'un tag `v*`

Pour déclencher une release :
```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## 🎨 Charte graphique

| Élément | Couleur | Code |
|---|---|---|
| Primaire | Bleu | `#2563EB` |
| Secondaire | Violet | `#7C3AED` |
| Accent | Orange | `#F59E0B` |
| Fond | Blanc | `#FFFFFF` |
| Fond secondaire | Gris clair | `#F8FAFC` |
| Texte principal | Noir | `#111827` |
| Succès | Vert | `#22C55E` |
| Erreur | Rouge | `#EF4444` |

---

## 🤝 Contribuer

Les contributions sont les bienvenues ! Merci de respecter les conventions suivantes :

1. Forkez le projet
2. Créez une branche (`git checkout -b feature/ma-fonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout de ma fonctionnalité'`)
4. Poussez vers la branche (`git push origin feature/ma-fonctionnalite`)
5. Ouvrez une Pull Request

Merci de respecter les règles de lint définies dans `analysis_options.yaml` avant toute soumission.

---

<p align="center">Développé avec ❤️ pour les élèves de Côte d'Ivoire</p>
