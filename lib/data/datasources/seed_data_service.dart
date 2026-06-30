import 'package:hive/hive.dart';
import '../models/course_model.dart';
import '../models/quiz_model.dart';
import '../../core/constants/app_constants.dart';

/// Seeds all initial data into Hive boxes on first launch.
class SeedDataService {
  SeedDataService._();

  static Future<void> seedIfNeeded() async {
    final coursesBox = Hive.box(AppConstants.coursesBox);
    if (coursesBox.isNotEmpty) return; // Already seeded
    await _seedCourses();
    await _seedExercises();
    await _seedBacSubjects();
    await _seedQuizzes();
  }

  // ─── COURSES ────────────────────────────────────────────────────────────────

  static Future<void> _seedCourses() async {
    final box = Hive.box(AppConstants.coursesBox);
    final courses = _buildCourses();
    for (final c in courses) {
      await box.put(c.id, c);
    }
  }

  static List<CourseModel> _buildCourses() => [
    // ── FRANÇAIS ──
    CourseModel(
      id: 'fr_001',
      subjectId: 'francais',
      title: 'La Dissertation Littéraire',
      chapter: 'Expression Écrite',
      orderIndex: 1,
      summary: 'Maîtriser la structure et la méthode de la dissertation littéraire au BAC.',
      content: '''# La Dissertation Littéraire

## Définition
La dissertation littéraire est un exercice de réflexion organisée sur une question posée à partir d\'un texte ou d\'une thématique littéraire. Elle évalue votre capacité à analyser, argumenter et illustrer.

## Structure en 3 parties

### I. Introduction
L\'introduction comprend :
- **L\'accroche** : phrase d\'entrée originale qui capte l\'attention
- **La présentation du sujet** : reformulation claire et neutre de la question
- **La problématique** : la vraie question que soulève le sujet
- **L\'annonce du plan** : présentation des grandes parties

**Exemple d\'accroche :** « Victor Hugo affirmait que "la littérature, c\'est la pensée armée". »

### II. Développement
Le développement comporte 2 ou 3 parties équilibrées, chacune comprenant :
- Une **idée directrice** (phrase-chapeau)
- Des **arguments** développés et logiques
- Des **exemples** tirés d\'œuvres littéraires
- Une **transition** vers la partie suivante

**Méthode A.E.I. :**
- **A**rgument : l\'idée que vous défendez
- **E**xemple : l\'œuvre ou l\'extrait qui illustre
- **I**nterprétation : l\'explication du lien entre A et E

### III. Conclusion
La conclusion comprend :
- Le **bilan** : synthèse des idées développées
- La **réponse** à la problématique posée
- L\'**ouverture** : élargissement vers une perspective plus large

## Les connecteurs logiques indispensables
- **Pour ajouter** : de plus, en outre, par ailleurs, également
- **Pour opposer** : cependant, néanmoins, toutefois, en revanche
- **Pour illustrer** : ainsi, c\'est le cas de, par exemple, notamment
- **Pour conclure** : en définitive, en somme, finalement, ainsi

## Conseils pratiques
1. Lisez le sujet au moins 3 fois avant d\'écrire
2. Faites un brouillon de plan avant de rédiger
3. Soignez l\'introduction et la conclusion
4. Vérifiez l\'orthographe et la ponctuation
5. Réservez 10 minutes pour la relecture finale''',
      tags: ['dissertation', 'méthode', 'rédaction', 'BAC'],
      difficulty: 'Moyen',
      estimatedMinutes: 45,
      tips: [
        'L\'introduction doit représenter environ 10% de votre copie.',
        'Chaque partie du développement doit avoir le même équilibre.',
        'Citez toujours vos sources (auteur, œuvre, siècle).',
        'Évitez le "je" et les formules familières.',
      ],
    ),

    CourseModel(
      id: 'fr_002',
      subjectId: 'francais',
      title: 'Le Commentaire de Texte',
      chapter: 'Expression Écrite',
      orderIndex: 2,
      summary: 'Analyser et commenter un texte littéraire de façon méthodique.',
      content: '''# Le Commentaire de Texte

## Qu\'est-ce qu\'un commentaire ?
Le commentaire de texte consiste à analyser un extrait littéraire en mettant en évidence ses caractéristiques stylistiques, thématiques et son sens profond.

## Les étapes de préparation

### 1. Lecture et identification
- Lisez le texte deux fois : une lecture globale, une lecture analytique
- Identifiez le **genre** (roman, poésie, théâtre, essai)
- Repérez le **registre** (lyrique, épique, dramatique, comique, tragique)
- Situez le **contexte** de l\'extrait

### 2. Repérage des procédés stylistiques
**Les figures de style :**
- *Métaphore* : comparaison implicite (« la vie est un long fleuve »)
- *Comparaison* : comparaison explicite avec « comme », « tel que »
- *Personnification* : attribuer des caractéristiques humaines à un objet
- *Hyperbole* : exagération expressive
- *Anaphore* : répétition en début de phrase ou de vers
- *Antithèse* : opposition de deux idées contraires

**Les effets de rythme :**
- Phrases courtes = urgence, tension
- Phrases longues = ampleur, méditation
- Enjambements (en poésie) = continuité, fluidité

### 3. Construction du plan
Généralement 2 ou 3 axes de lecture, chacun analysant un aspect du texte :
- Axe 1 : la forme / le style
- Axe 2 : le fond / les thèmes
- Axe 3 : la portée / le sens

## Rédaction du commentaire

### Introduction
1. Présentation de l\'auteur et de l\'œuvre
2. Situation de l\'extrait dans l\'œuvre
3. Présentation du projet de lecture (axes)

### Développement
Pour chaque axe :
- Titre de l\'axe (idée générale)
- Sous-parties avec citations précises
- Analyse des procédés et de leurs effets

### Conclusion
- Bilan des axes étudiés
- Réponse au projet de lecture
- Ouverture

## Règles d\'or
✅ Citez précisément le texte entre guillemets
✅ Analysez toujours l\'effet produit (pourquoi l\'auteur a fait ce choix)
✅ Ne paraphrasez pas (ne répétez pas le texte sans l\'analyser)
✅ Utilisez le présent de narration''',
      tags: ['commentaire', 'texte', 'analyse', 'stylistique'],
      difficulty: 'Difficile',
      estimatedMinutes: 50,
      tips: [
        'Ne jamais paraphraser : analysez, n\'expliquez pas simplement ce qui se passe.',
        'Une citation doit toujours être suivie d\'une analyse.',
        'Le plan doit être annoncé clairement dans l\'introduction.',
        'Pensez aux effets produits sur le lecteur.',
      ],
    ),

    // ── MATHÉMATIQUES ──
    CourseModel(
      id: 'math_001',
      subjectId: 'mathematiques',
      title: 'Les Suites Numériques',
      chapter: 'Analyse',
      orderIndex: 1,
      summary: 'Comprendre et maîtriser les suites arithmétiques, géométriques et leurs applications.',
      content: '''# Les Suites Numériques

## Définition
Une suite numérique est une fonction définie sur ℕ (ou une partie de ℕ) à valeurs dans ℝ. On note (uₙ) la suite dont le terme général est uₙ.

## 1. Suites arithmétiques

### Définition
Une suite (uₙ) est **arithmétique** de raison r si :
```
u_{n+1} = uₙ + r  pour tout n ∈ ℕ
```

### Formule du terme général
```
uₙ = u₀ + n·r
```
ou de manière plus générale :
```
uₙ = uₚ + (n - p)·r
```

### Somme des termes
La somme des (n+1) premiers termes :
```
S = (n+1) × (u₀ + uₙ) / 2
```
**Moyen mnémotechnique :** "Nombre de termes × Moyenne du premier et dernier terme"

### Exemple
Soit (uₙ) une suite arithmétique telle que u₀ = 3 et r = 5.
- u₁ = 3 + 5 = 8
- u₂ = 3 + 2×5 = 13
- uₙ = 3 + 5n
- Somme S₁₀ = 11 × (3 + 53)/2 = 11 × 28 = 308

## 2. Suites géométriques

### Définition
Une suite (uₙ) est **géométrique** de raison q (q ≠ 0) si :
```
u_{n+1} = uₙ × q  pour tout n ∈ ℕ
```

### Formule du terme général
```
uₙ = u₀ × qⁿ
```

### Somme des termes (q ≠ 1)
```
S = u₀ × (1 - qⁿ⁺¹) / (1 - q)
```

### Exemple
Placement de 100 000 FCFA à 5% par an :
- u₀ = 100 000
- q = 1,05
- Après 10 ans : u₁₀ = 100 000 × 1,05¹⁰ ≈ 162 889 FCFA

## 3. Convergence et divergence

### Limite d\'une suite
- Si lim uₙ = L (L fini), la suite **converge** vers L
- Si lim uₙ = ±∞, la suite **diverge**

### Théorèmes fondamentaux
- **Théorème des gendarmes :** Si vₙ ≤ uₙ ≤ wₙ et lim vₙ = lim wₙ = L, alors lim uₙ = L
- **Suite monotone bornée :** Toute suite croissante et majorée converge

## 4. Récurrences et démonstrations

### Raisonnement par récurrence
Pour démontrer qu\'une propriété P(n) est vraie pour tout n ≥ n₀ :
1. **Initialisation :** Vérifier P(n₀)
2. **Hérédité :** Supposer P(n) vraie, démontrer P(n+1)
3. **Conclusion :** Par le principe de récurrence, P(n) est vraie pour tout n ≥ n₀

### Exemple de récurrence
Démontrer que pour tout n ∈ ℕ : uₙ = 3 + 5n (suite arithmétique)
- **Init :** u₀ = 3 = 3 + 5×0 ✓
- **Hér :** Si uₙ = 3 + 5n, alors u_{n+1} = uₙ + 5 = 3 + 5n + 5 = 3 + 5(n+1) ✓''',
      tags: ['suites', 'arithmétique', 'géométrique', 'convergence'],
      difficulty: 'Moyen',
      estimatedMinutes: 60,
      tips: [
        'Toujours vérifier si la suite est arithmétique (différence constante) ou géométrique (rapport constant).',
        'Dans un exercice de placement bancaire, pensez aux suites géométriques.',
        'La récurrence est obligatoire pour les démonstrations formelles.',
        'Dessinez un tableau de valeurs pour visualiser la suite.',
      ],
    ),

    CourseModel(
      id: 'math_002',
      subjectId: 'mathematiques',
      title: 'Les Limites de Fonctions',
      chapter: 'Analyse',
      orderIndex: 2,
      summary: 'Calculer et interpréter les limites de fonctions – règles et techniques.',
      content: '''# Les Limites de Fonctions

## Définition intuitive
La limite d\'une fonction f en a est la valeur vers laquelle f(x) tend quand x s\'approche de a.

## Formes indéterminées et leur levée

### Les 4 formes indéterminées
1. **∞ - ∞** → Factoriser par le terme dominant
2. **0/0** → Factoriser et simplifier
3. **∞/∞** → Diviser par le terme dominant
4. **0 × ∞** → Réécrire comme 0/0 ou ∞/∞

### Technique 1 : Factorisation (0/0)
```
lim_{x→2} (x² - 4)/(x - 2)
= lim_{x→2} (x+2)(x-2)/(x-2)
= lim_{x→2} (x+2)
= 4
```

### Technique 2 : Terme dominant (∞/∞)
Pour les polynômes, on regarde le terme de plus haut degré :
```
lim_{x→∞} (3x² + 2x + 1)/(x² - 5)
= lim_{x→∞} 3x²/x²
= 3
```

### Technique 3 : Conjugué (pour les radicaux)
```
lim_{x→0} (√(1+x) - 1)/x
Multiplier par (√(1+x) + 1)/(√(1+x) + 1)
= lim_{x→0} x / (x(√(1+x) + 1))
= lim_{x→0} 1/(√(1+x) + 1)
= 1/2
```

## Continuité et dérivabilité

### Continuité en a
f est continue en a si :
- f(a) existe
- lim_{x→a} f(x) existe
- lim_{x→a} f(x) = f(a)

### Théorème des valeurs intermédiaires (TVI)
Si f est continue sur [a,b] et si f(a) et f(b) sont de signes opposés, alors il existe c ∈ ]a,b[ tel que f(c) = 0.

## Asymptotes

| Type | Condition | Équation |
|------|-----------|----------|
| Verticale | lim_{x→a} f(x) = ±∞ | x = a |
| Horizontale | lim_{x→∞} f(x) = L | y = L |
| Oblique | lim_{x→∞} [f(x) - (ax+b)] = 0 | y = ax+b |''',
      tags: ['limites', 'continuité', 'asymptotes', 'analyse'],
      difficulty: 'Difficile',
      estimatedMinutes: 55,
      tips: [
        'Identifiez toujours la forme indéterminée avant de choisir la technique.',
        'La règle de L\'Hôpital s\'applique aux formes 0/0 et ∞/∞.',
        'Vérifiez la continuité avant d\'appliquer le TVI.',
      ],
    ),

    // ── SVT ──
    CourseModel(
      id: 'svt_001',
      subjectId: 'svt',
      title: 'La Mitose et la Méiose',
      chapter: 'Génétique et Reproduction',
      orderIndex: 1,
      summary: 'Comprendre les mécanismes de division cellulaire : mitose et méiose.',
      content: '''# La Mitose et la Méiose

## I. La Mitose

### Définition
La mitose est une division cellulaire produisant deux cellules filles **identiques** à la cellule mère, avec le même nombre de chromosomes (division équationnelle).

### Les 4 phases de la mitose

#### 1. Prophase
- La chromatine se condense → chromosomes visibles
- Chaque chromosome est formé de 2 chromatides sœurs reliées par le centromère
- La membrane nucléaire disparaît
- Le fuseau de division se met en place

#### 2. Métaphase
- Les chromosomes s\'alignent sur la **plaque équatoriale** (plan médian)
- C\'est la phase où les chromosomes sont le mieux visibles
- Le caryotype est réalisé à cette phase

#### 3. Anaphase
- Les chromatides sœurs se séparent
- Les chromosomes migrent vers les pôles opposés
- La cellule s\'allonge

#### 4. Télophase
- Les chromosomes se décondensent
- La membrane nucléaire se reforme
- La cytocinèse (division du cytoplasme) se réalise

### Résultat
2 cellules filles à **2n** chromosomes (diploïdes)

## II. La Méiose

### Définition
La méiose produit 4 cellules filles ayant **moitié moins** de chromosomes que la cellule mère. Elle est à la base de la reproduction sexuée.

### Les deux divisions de la méiose

#### Méiose I (division réductionnelle)
- Sépare les chromosomes homologues
- Résultat : 2 cellules à n chromosomes (chacune à 2 chromatides)

#### Méiose II (division équationnelle)
- Sépare les chromatides sœurs
- Résultat : 4 cellules à n chromosomes (à 1 chromatide)

### Crossing-over (enjambement)
Lors de la prophase I, des échanges de segments entre chromosomes homologues créent de **nouvelles combinaisons génétiques** → brassage interchromosomique.

## III. Comparaison

| Critère | Mitose | Méiose |
|---------|--------|--------|
| Lieu | Toutes cellules | Gonades |
| Nb de divisions | 1 | 2 |
| Cellules produites | 2 | 4 |
| Nb chromosomes | 2n → 2n | 2n → n |
| Génotype | Identique | Varié |
| Rôle | Croissance, réparation | Reproduction sexuée |

## IV. Anomalies
- **Trisomie 21** : non-disjonction lors de la méiose → 3 chromosomes 21 (47 chromosomes au total)
- **Monosomie X** (syndrome de Turner) : une cellule reçoit 0 chromosome X''',
      tags: ['mitose', 'méiose', 'chromosomes', 'division cellulaire'],
      difficulty: 'Moyen',
      estimatedMinutes: 50,
      tips: [
        'Mémorisez l\'acronyme PMAT (Prophase, Métaphase, Anaphase, Télophase).',
        'La méiose I est réductionnelle (2n → n), la méiose II est équationnelle (n → n).',
        'Le crossing-over se produit uniquement en prophase I de la méiose.',
        'Entraînez-vous à schématiser chaque phase.',
      ],
    ),

    // ── PHYSIQUE-CHIMIE ──
    CourseModel(
      id: 'pc_001',
      subjectId: 'physique_chimie',
      title: 'Les Lois de Newton',
      chapter: 'Mécanique',
      orderIndex: 1,
      summary: 'Maîtriser les trois lois de Newton et leurs applications en mécanique.',
      content: '''# Les Lois de Newton

## Rappels préliminaires

### Grandeurs vectorielles
- **Force F** (en Newtons, N)
- **Vitesse v** (en m/s)
- **Accélération a** (en m/s²)

### Référentiel et repère
Un **référentiel** est un objet par rapport auquel on étudie le mouvement. Un référentiel est **galiléen** (inertiel) si le principe d\'inertie y est vérifié.

---

## Première loi de Newton (Principe d\'inertie)

> **"Tout corps persévère dans l\'état de repos ou de mouvement rectiligne uniforme dans lequel il se trouve, à moins que des forces n\'agissent sur lui pour le faire changer de cet état."**

### Conséquences
- Si ΣF⃗ = 0⃗ → le corps est au **repos** ou en **MRU** (mouvement rectiligne uniforme)
- Réciproquement, si le corps est en MRU ou au repos → ΣF⃗ = 0⃗

---

## Deuxième loi de Newton (Principe fondamental de la dynamique)

> **ΣF⃗ = m × a⃗**

Où :
- ΣF⃗ = somme vectorielle de toutes les forces (N)
- m = masse du corps (kg)
- a⃗ = vecteur accélération (m/s²)

### Application – Plan horizontal avec frottement
Un bloc de masse m = 5 kg sur un plan horizontal.
Force motrice F = 20 N, force de frottement f = 8 N.

**Bilan des forces :**
- Horizontalement : F - f = m·a → 20 - 8 = 5·a → a = 2,4 m/s²
- Verticalement : N - P = 0 → N = P = mg = 5 × 10 = 50 N

### Application – Plan incliné
Pour un plan incliné d\'angle θ :
- Composante parallèle : P·sinθ
- Composante perpendiculaire : P·cosθ

---

## Troisième loi de Newton (Principe des actions réciproques)

> **"Toute action d\'un corps A sur un corps B s\'accompagne d\'une réaction du corps B sur A, égale et opposée."**

F⃗_{A/B} = -F⃗_{B/A}

### Caractéristiques des forces réaction-action
- Même droite d\'action
- Même norme (intensité)
- Sens opposés
- S\'appliquent sur des corps différents

---

## Équations horaires du mouvement

### Mouvement uniformément accéléré
À partir de PFD : a = constante

- **v(t) = v₀ + a·t**
- **x(t) = x₀ + v₀·t + ½·a·t²**
- **v² = v₀² + 2·a·(x - x₀)**

### Exemple : Chute libre
Un objet lâché sans vitesse initiale (h = 20 m, g = 10 m/s²) :
- a = g = 10 m/s² (vers le bas)
- h = ½·g·t² → t = √(2h/g) = √(4) = 2 s
- v à l\'impact : v = g·t = 10 × 2 = 20 m/s''',
      tags: ['Newton', 'forces', 'mécanique', 'dynamique', 'PFD'],
      difficulty: 'Moyen',
      estimatedMinutes: 55,
      tips: [
        'Toujours commencer par un bilan des forces AVANT d\'appliquer le PFD.',
        'Le PFD s\'applique uniquement dans un référentiel galiléen.',
        'Projetez les forces sur un repère (Ox, Oy) avant de calculer.',
        'Les forces action-réaction s\'appliquent sur des objets DIFFÉRENTS.',
      ],
    ),

    // ── HISTOIRE-GEO ──
    CourseModel(
      id: 'hg_001',
      subjectId: 'histoire_geo',
      title: 'La Décolonisation en Afrique',
      chapter: 'Histoire Contemporaine',
      orderIndex: 1,
      summary: 'Les causes, le déroulement et les conséquences de la décolonisation africaine.',
      content: '''# La Décolonisation en Afrique

## I. Contexte et causes

### Facteurs internes
- **Émergence d\'élites africaines** formées dans les universités européennes
- **Développement du nationalisme** africain après la Seconde Guerre mondiale
- **Rôle des partis politiques** et syndicats (exemple : RDA de Félix Houphouët-Boigny)
- **Influence des chefs religieux** et traditionnels

### Facteurs externes
- **La Charte de l\'Atlantique (1941)** : Roosevelt et Churchill proclament le droit des peuples à l\'autodétermination
- **La Conférence de Bandung (1955)** : 29 pays d\'Asie et d\'Afrique affirment le droit des peuples à disposer d\'eux-mêmes
- **Pression de l\'ONU** et des superpuissances (USA, URSS) contre le colonialisme
- **L\'affaiblissement des métropoles** européennes après la guerre

## II. Les formes de décolonisation

### Voie pacifique / négociée
Cas de la plupart des pays d\'Afrique francophone :
- En Côte d\'Ivoire, Félix Houphouët-Boigny négocie l\'indépendance obtenue le **7 août 1960**
- Au Sénégal, le Soudan français → indépendance en 1960
- Cadre : **La Loi-Cadre Defferre (1956)** puis référendum de 1958

### Voie armée / révolutionnaire
- **Algérie** : guerre d\'indépendance 1954-1962 (FLN contre France)
- **Kenya** : révolte des Mau-Mau 1952-1960
- **Mozambique, Angola** : luttes armées contre le Portugal

### L\'Afrique du Sud : apartheid
- L\'apartheid (1948-1994) = ségrégation raciale légale
- Nelson Mandela et l\'ANC luttent contre ce régime
- Abolition en 1991, premières élections multiraciales en 1994

## III. La vague des indépendances

### 1960 : L\'Année de l\'Afrique
En 1960, **17 pays africains** accèdent à l\'indépendance, dont :
- Côte d\'Ivoire (7 août)
- Sénégal
- Mali
- Congo (Brazzaville et Kinshasa)
- Cameroun
- Togo

## IV. Conséquences

### Politiques
- Création d\'États souverains avec leurs propres institutions
- Instabilité politique : coups d\'État militaires fréquents dans les années 60-70
- Conflits frontaliers liés aux frontières héritées de la colonisation

### Économiques
- Maintien de liens économiques avec les anciennes métropoles (**néocolonialisme**)
- Économies dépendantes de l\'exportation de matières premières
- Faiblesse industrielle

### Sociales et culturelles
- Problèmes d\'identité nationale (pluriethnicité)
- Développement d\'une culture hybride africaine-occidentale

## V. La Côte d\'Ivoire indépendante
- **Indépendance** : 7 août 1960
- **Premier président** : Félix Houphouët-Boigny (1960-1993)
- **Capitale** : Yamoussoukro (politique), Abidjan (économique)
- **Stabilité** relative grâce au « miracle ivoirien » des années 60-70''',
      tags: ['décolonisation', 'Afrique', 'indépendances', '1960', 'Côte d\'Ivoire'],
      difficulty: 'Moyen',
      estimatedMinutes: 40,
      tips: [
        'Retenez la date du 7 août 1960 pour l\'indépendance de la Côte d\'Ivoire.',
        'Distinguez bien les voies pacifiques et armées de décolonisation.',
        'La Conférence de Bandung (1955) est un repère chronologique important.',
        'Pensez à citer des exemples précis dans vos développements.',
      ],
    ),

    // ── ANGLAIS ──
    CourseModel(
      id: 'en_001',
      subjectId: 'anglais',
      title: 'Les Temps en Anglais',
      chapter: 'Grammaire',
      orderIndex: 1,
      summary: 'Maîtriser les principaux temps de la langue anglaise pour le BAC.',
      content: '''# Les Temps en Anglais

## 1. Simple Present (Présent simple)

### Utilisation
- Vérités générales / habitudes : *The sun rises in the east.*
- Routines (avec souvent : always, often, never, every day) : *She goes to school every day.*
- Commentaires sportifs / narrations au présent

### Formation
| Sujet | Forme affirmative | Forme négative | Forme interrogative |
|-------|-------------------|----------------|---------------------|
| I/You/We/They | work | don\'t work | Do you work? |
| He/She/It | works (+s) | doesn\'t work | Does he work? |

---

## 2. Present Continuous (Présent continu)

### Utilisation
- Action en cours : *I am studying right now.*
- Futur proche prévu : *We are leaving tomorrow.*

### Formation
Subject + am/is/are + verb-ing

---

## 3. Simple Past (Passé simple)

### Utilisation
- Action terminée dans le passé : *She visited Abidjan last year.*

### Formation
- Verbes réguliers : verb + **-ed** (walk → walked)
- Verbes irréguliers : à mémoriser (go → went, have → had)

---

## 4. Present Perfect (Passé composé)

### Utilisation
- Expérience de vie (ever, never) : *I have never been to Europe.*
- Action passée avec résultat présent : *She has lost her keys.*
- With : just, already, yet, since, for

### Formation
Subject + have/has + past participle

### Present Perfect vs Simple Past
| Present Perfect | Simple Past |
|-----------------|-------------|
| I have seen that film. (expérience) | I saw that film yesterday. (moment précis) |
| She has lived here for 10 years. | She lived in Paris in 2010. |

---

## 5. Future Tenses

### Will + infinitive
- Décision spontanée : *I\'ll help you!*
- Prédiction : *It will rain tomorrow.*

### Going to + infinitive
- Plan prévu : *I\'m going to study medicine.*
- Évidence visible : *Look at those clouds! It\'s going to rain.*

---

## 6. Conditional (Conditionnel)

### Type 1 (situation réelle/possible)
If + Simple Present → Will + infinitive
*If you study hard, you will pass the BAC.*

### Type 2 (situation hypothétique/irréelle)
If + Simple Past → Would + infinitive
*If I were rich, I would travel the world.*

### Type 3 (situation passée irréelle)
If + Past Perfect → Would have + past participle
*If she had studied, she would have passed.*

---

## 7. Verbes irréguliers essentiels

| Infinitive | Past Simple | Past Participle | Traduction |
|------------|-------------|-----------------|------------|
| be | was/were | been | être |
| go | went | gone | aller |
| have | had | had | avoir |
| do | did | done | faire |
| see | saw | seen | voir |
| write | wrote | written | écrire |
| take | took | taken | prendre |
| know | knew | known | savoir |
| give | gave | given | donner |
| come | came | come | venir |''',
      tags: ['temps', 'grammaire', 'anglais', 'verbes'],
      difficulty: 'Facile',
      estimatedMinutes: 40,
      tips: [
        'Mémorisez les verbes irréguliers par groupes phonétiques.',
        'Present Perfect ≠ Simple Past : attention au moment de l\'action.',
        'Le conditionnel Type 2 utilise "were" pour tous les sujets (If I were...).',
        'Pratiquez en écrivant des phrases sur votre quotidien.',
      ],
    ),

    // ── PHILOSOPHIE ──
    CourseModel(
      id: 'philo_001',
      subjectId: 'philosophie',
      title: 'La Conscience',
      chapter: 'L\'Être Humain',
      orderIndex: 1,
      summary: 'Analyser la notion de conscience : définition, formes et enjeux philosophiques.',
      content: '''# La Conscience

## I. Définition et étymologie

Le mot **conscience** vient du latin *conscientia* (savoir avec). Il désigne la faculté qu\'a l\'être humain de se représenter lui-même et le monde qui l\'entoure.

### Deux sens principaux
1. **Conscience psychologique** : perception immédiate de nos états intérieurs et du monde extérieur
2. **Conscience morale** : capacité à distinguer le bien du mal et à juger nos actes

---

## II. La conscience de soi

### Descartes et le *Cogito*
> *"Je pense, donc je suis."* (Cogito ergo sum)

Pour Descartes, la conscience est la **certitude première** : même si je doute de tout, je ne peux pas douter que je pense. La conscience de soi est donc le fondement de toute connaissance.

### Sartre : la conscience comme néant
Pour Sartre, la conscience n\'est pas une chose. Elle est ce par quoi les choses apparaissent. La conscience est un **néant** qui se définit par ce qu\'elle n\'est pas.

---

## III. L\'inconscient freudien

Freud remet en question la toute-puissance de la conscience.

### Le modèle topique (1900)
- **Conscient** : ce dont on a actuellement conscience
- **Préconscient** : contenu accessible à la conscience sous certaines conditions
- **Inconscient** : contenu refoulé, inaccessible directement

### Le modèle structural (1923)
- **Moi** : instance médiatrice, en contact avec la réalité
- **Ça** : réservoir des pulsions et désirs
- **Surmoi** : intériorisation des normes sociales et morales

### Conséquence philosophique
*L\'homme n\'est pas maître dans sa propre maison* (Freud). La conscience n\'est que la partie émergée d\'un iceberg.

---

## IV. Conscience et liberté

### La conscience comme condition de la liberté
Pour **Kant**, la conscience morale est ce qui nous permet d\'être libres : en obéissant à la raison (et non à nos désirs), nous sommes autonomes.

> *"Agis de telle sorte que la maxime de ta volonté puisse toujours valoir en même temps comme principe d\'une législation universelle."* (Impératif catégorique)

### L\'aliénation de la conscience
**Marx** : la conscience peut être **aliénée** par les conditions économiques et sociales. Les idées dominantes d\'une époque sont celles de la classe dominante.

---

## V. Problèmes philosophiques contemporains

### Le problème difficile de la conscience
Comment expliquer qu\'un phénomène physique (activité cérébrale) donne naissance à une expérience subjective (ce qu\'on ressent) ? Ce problème reste ouvert en philosophie de l\'esprit.

### Intelligence artificielle et conscience
Les machines peuvent-elles être conscientes ? Le **test de Turing** (1950) teste si une machine peut imiter l\'intelligence humaine, mais l\'imitation suffit-elle à créer la conscience ?

---

## VI. Plan type pour une dissertation sur la conscience

**Sujet exemple :** *Peut-on connaître son inconscient ?*

- **I.** La conscience de soi semble accessible par l\'introspection (Descartes)
- **II.** Mais l\'inconscient résiste par définition à la conscience (Freud)
- **III.** Cependant, la psychanalyse offre un chemin indirect vers l\'inconscient''',
      tags: ['conscience', 'Descartes', 'Freud', 'inconscient', 'philosophie'],
      difficulty: 'Difficile',
      estimatedMinutes: 50,
      tips: [
        'Apprenez quelques citations clés de Descartes, Freud et Kant.',
        'En philosophie, définissez toujours les termes du sujet en introduction.',
        'Le plan doit être dialectique : thèse / antithèse / synthèse.',
        'Chaque argument doit être illustré par un exemple ou un auteur.',
      ],
    ),

    // ── ÉCONOMIE ──
    CourseModel(
      id: 'eco_001',
      subjectId: 'economie',
      title: 'L\'Offre et la Demande',
      chapter: 'Microéconomie',
      orderIndex: 1,
      summary: 'Comprendre les lois de l\'offre et de la demande et l\'équilibre du marché.',
      content: '''# L\'Offre et la Demande

## I. La Demande

### Définition
La **demande** représente la quantité d\'un bien ou service que les consommateurs sont prêts à acheter à un prix donné, pendant une période donnée.

### La loi de la demande
> *Toutes choses égales par ailleurs, quand le prix augmente, la quantité demandée diminue.*

La courbe de demande est donc **décroissante** (pente négative).

### Déterminants de la demande
- **Prix du bien** (relation inverse)
- **Revenus des consommateurs** (+ revenus → + demande pour biens normaux)
- **Prix des biens substituts** (Coca-Cola vs Pepsi)
- **Prix des biens complémentaires** (voiture + essence)
- **Goûts et préférences**
- **Anticipations** des consommateurs

---

## II. L\'Offre

### Définition
L\'**offre** représente la quantité d\'un bien que les producteurs sont prêts à vendre à un prix donné.

### La loi de l\'offre
> *Toutes choses égales par ailleurs, quand le prix augmente, la quantité offerte augmente.*

La courbe d\'offre est donc **croissante** (pente positive).

### Déterminants de l\'offre
- **Prix du bien**
- **Coûts de production** (matières premières, salaires)
- **Technologie** (amélioration → offre augmente)
- **Réglementation** (taxes, subventions)
- **Nombre de producteurs**

---

## III. L\'Équilibre du marché

### Point d\'équilibre
L\'équilibre est atteint quand **Offre = Demande**.
- **Prix d\'équilibre (P*)** : prix auquel le marché se vide
- **Quantité d\'équilibre (Q*)** : quantité échangée à l\'équilibre

### Surplus et pénurie
| Situation | Prix | Conséquence |
|-----------|------|-------------|
| Prix > P* | Trop élevé | **Surplus** (excès d\'offre) → prix baisse |
| Prix < P* | Trop bas | **Pénurie** (excès de demande) → prix monte |

### Exemple concret : Marché de l\'igname
Si la récolte d\'igname est abondante (offre augmente) → le prix baisse.
Si une sécheresse réduit la production (offre diminue) → prix augmente.

---

## IV. Élasticité

### Élasticité-prix de la demande
```
Ed = (ΔQ/Q) / (ΔP/P)
```
- |Ed| > 1 : demande **élastique** (sensible au prix)
- |Ed| < 1 : demande **inélastique** (peu sensible au prix)
- Exemple : médicaments essentiels → inélastique

### Élasticité-revenu
- Bien **normal** : élasticité > 0 (+ revenu → + consommation)
- Bien **inférieur** : élasticité < 0 (+ revenu → - consommation)
- Bien **de luxe** : élasticité > 1

---

## V. Les défaillances du marché
- **Externalités** : effets sur des tiers non pris en compte (pollution)
- **Biens publics** : non-rival, non-exclusif (routes, éclairage public)
- **Asymétrie d\'information** : une partie est mieux informée que l\'autre
- **Monopoles** : un seul vendeur fixe le prix''',
      tags: ['offre', 'demande', 'marché', 'équilibre', 'élasticité'],
      difficulty: 'Facile',
      estimatedMinutes: 40,
      tips: [
        'La loi de l\'offre et de la demande est le fondement de toute la microéconomie.',
        'Entraînez-vous à tracer les courbes d\'offre et de demande.',
        'L\'élasticité mesure la sensibilité : mémorisez les formules.',
        'Utilisez des exemples ivoiriens dans vos arguments (marché d\'Abidjan, cacao, etc.).',
      ],
    ),

    // ── INFORMATIQUE ──
    CourseModel(
      id: 'info_001',
      subjectId: 'informatique',
      title: 'Introduction aux Algorithmes',
      chapter: 'Algorithmique',
      orderIndex: 1,
      summary: 'Comprendre la notion d\'algorithme et apprendre à en écrire de simples.',
      content: '''# Introduction aux Algorithmes

## I. Définition

Un **algorithme** est une suite finie et ordonnée d\'instructions permettant de résoudre un problème ou d\'effectuer une tâche.

### Caractéristiques d\'un bon algorithme
- **Finitude** : il doit se terminer
- **Précision** : chaque étape doit être claire et non ambiguë
- **Entrée(s)** : données initiales
- **Sortie(s)** : résultats produits
- **Efficacité** : il doit fonctionner correctement

---

## II. Structure de base d\'un algorithme

```
Algorithme : Nom_de_l_algorithme
Variables : (déclaration des variables)
Début
    Instruction 1
    Instruction 2
    ...
Fin
```

---

## III. Les structures de contrôle

### 1. Structure séquentielle
Les instructions s\'exécutent les unes après les autres.

```
Début
    Lire A
    Lire B
    S ← A + B
    Écrire "La somme est : ", S
Fin
```

### 2. Structure conditionnelle (SI...ALORS...SINON)

```
Si (condition) Alors
    Instructions si vrai
Sinon
    Instructions si faux
Fin Si
```

**Exemple :** Vérifier si un nombre est pair
```
Si (N MOD 2 = 0) Alors
    Écrire "N est pair"
Sinon
    Écrire "N est impair"
Fin Si
```

### 3. Structure itérative (boucles)

#### Boucle TANT QUE
```
Tant que (condition) Faire
    Instructions
Fin Tant que
```

#### Boucle POUR
```
Pour i ← 1 à 10 Faire
    Écrire i
Fin Pour
```

---

## IV. Exemple complet : Calculer la moyenne

```
Algorithme : CalculMoyenne
Variables :
    notes : tableau de 5 réels
    somme, moyenne : réel
    i : entier

Début
    somme ← 0
    Pour i ← 1 à 5 Faire
        Écrire "Note ", i, " : "
        Lire notes[i]
        somme ← somme + notes[i]
    Fin Pour
    
    moyenne ← somme / 5
    
    Écrire "Votre moyenne est : ", moyenne
    
    Si (moyenne >= 10) Alors
        Écrire "Admis(e) !"
    Sinon
        Écrire "Non admis(e)"
    Fin Si
Fin
```

---

## V. Complexité algorithmique

### Notion de complexité
La **complexité** mesure les ressources (temps, mémoire) nécessaires à l\'exécution d\'un algorithme en fonction de la taille des données n.

| Complexité | Notation | Exemple |
|------------|----------|---------|
| Constante | O(1) | Accès tableau direct |
| Logarithmique | O(log n) | Recherche dichotomique |
| Linéaire | O(n) | Parcours tableau |
| Quadratique | O(n²) | Tri à bulles |

### Tri à bulles (exemple)
```
Pour i ← 1 à n-1 Faire
    Pour j ← 1 à n-i Faire
        Si T[j] > T[j+1] Alors
            temp ← T[j]
            T[j] ← T[j+1]
            T[j+1] ← temp
        Fin Si
    Fin Pour
Fin Pour
```''',
      tags: ['algorithme', 'programmation', 'structures', 'boucles'],
      difficulty: 'Facile',
      estimatedMinutes: 45,
      tips: [
        'Décomposez toujours le problème avant d\'écrire l\'algorithme.',
        'Tracez l\'exécution pas à pas sur un exemple simple pour vérifier.',
        'Les boucles POUR sont pour un nombre connu d\'itérations, TANT QUE pour un nombre inconnu.',
        'Commentez votre code pour faciliter la compréhension.',
      ],
    ),
  ];

  // ─── EXERCISES ──────────────────────────────────────────────────────────────

  static Future<void> _seedExercises() async {
    final box = Hive.box(AppConstants.coursesBox);
    // We reuse coursesBox with a prefix for exercises
    final exercises = _buildExercises();
    for (final e in exercises) {
      await box.put('ex_${e.id}', e);
    }
  }

  static List<ExerciseModel> _buildExercises() => [
    ExerciseModel(
      id: 'ex_math_001',
      subjectId: 'mathematiques',
      courseId: 'math_001',
      title: 'Suite arithmétique – Application directe',
      difficulty: 'Facile',
      points: 4,
      statement: '''Une suite arithmétique (uₙ) vérifie : u₁ = 7 et u₄ = 16.

1) Calculer la raison r de la suite.
2) Donner l\'expression de uₙ en fonction de n.
3) Calculer S = u₁ + u₂ + ... + u₁₀.''',
      solution: '''**1) Calcul de la raison r**

u₄ = u₁ + (4 - 1) × r
16 = 7 + 3r
3r = 9
**r = 3**

**2) Expression de uₙ**

uₙ = u₁ + (n - 1) × r
uₙ = 7 + (n - 1) × 3
uₙ = 7 + 3n - 3
**uₙ = 3n + 4**

*Vérification :* u₁ = 3(1) + 4 = 7 ✓ | u₄ = 3(4) + 4 = 16 ✓

**3) Calcul de S = u₁ + ... + u₁₀**

S₁₀ = 10 × (u₁ + u₁₀) / 2

u₁₀ = 3(10) + 4 = 34

S₁₀ = 10 × (7 + 34) / 2 = 10 × 41/2 = **205**''',
      steps: [
        'Identifier les données : u₁ = 7, u₄ = 16',
        'Utiliser la formule : uₙ = u₁ + (n-1)r pour trouver r',
        'Exprimer uₙ en fonction de n',
        'Appliquer la formule de la somme : S = nb_termes × (premier + dernier) / 2',
      ],
    ),

    ExerciseModel(
      id: 'ex_pc_001',
      subjectId: 'physique_chimie',
      courseId: 'pc_001',
      title: 'Application du PFD – Plan incliné',
      difficulty: 'Moyen',
      points: 6,
      statement: '''Un bloc de masse m = 2 kg est posé sur un plan incliné d\'angle θ = 30°.
On donne g = 10 m/s². Le plan est sans frottement.

1) Faire le bilan des forces exercées sur le bloc.
2) Appliquer le PFD (Principe Fondamental de la Dynamique).
3) Calculer l\'accélération du bloc.
4) Si le bloc part du repos, quelle est sa vitesse après 3 secondes ?''',
      solution: '''**1) Bilan des forces**
- Poids P⃗ : vertical vers le bas, |P| = mg = 2 × 10 = 20 N
- Réaction normale N⃗ : perpendiculaire au plan, vers l\'extérieur
- (Pas de frottement)

**2) Application du PFD**

On choisit un repère (Ox parallèle au plan vers le bas, Oy perpendiculaire).

Projection sur Ox : mg·sin(θ) = m·a
Projection sur Oy : N - mg·cos(θ) = 0 → N = mg·cos(θ)

**3) Calcul de l\'accélération**

a = g·sin(θ) = 10 × sin(30°) = 10 × 0,5 = **5 m/s²**

**4) Vitesse après 3 secondes**

v(t) = v₀ + a·t = 0 + 5 × 3 = **15 m/s**''',
      steps: [
        'Identifier toutes les forces (poids, réaction normale, frottements éventuels)',
        'Choisir un repère adapté (parallèle et perpendiculaire au plan)',
        'Projeter les forces sur chaque axe',
        'Isoler l\'accélération a',
        'Utiliser v = v₀ + at pour la vitesse',
      ],
    ),
  ];

  // ─── BAC SUBJECTS ────────────────────────────────────────────────────────────

  static Future<void> _seedBacSubjects() async {
    final box = Hive.box(AppConstants.coursesBox);
    final subjects = _buildBacSubjects();
    for (final s in subjects) {
      await box.put('bac_${s.id}', s);
    }
  }

  static List<BacSubjectModel> _buildBacSubjects() => [
    BacSubjectModel(
      id: 'bac_fr_2023_D',
      subjectId: 'francais',
      seriesId: 'D',
      year: 2023,
      session: 'Session 1',
      title: 'BAC 2023 – Français – Série D – Session 1',
      content: '''## SUJET DE FRANÇAIS – BAC 2023 – Série D

**Durée : 4 heures | Coefficient : 5**

---

### TEXTE

*Extrait de "L\'Enfant Noir" de Camara Laye (1953)*

> "J\'étais enfant et je jouais près de la case de mon père. C\'était là, devant la case, que mon père avait son atelier ; et son atelier, c\'était simplement la véranda de la case, mais une véranda très large, très propre..."

---

### PREMIÈRE PARTIE : COMMENTAIRE DE TEXTE (10 points)

Vous commenterez cet extrait en mettant en évidence :
- Le cadre et l\'atmosphère de la scène
- La relation père-fils
- Les valeurs culturelles africaines exprimées

### DEUXIÈME PARTIE : DISSERTATION (10 points)

**Sujet :** *"La littérature africaine est-elle le reflet fidèle des réalités du continent ?"*

Vous répondrez à cette question en vous appuyant sur des œuvres africaines que vous avez étudiées.''',
      correction: '''## CORRIGÉ INDICATIF

### COMMENTAIRE DE TEXTE

**Introduction**
Camara Laye, auteur guinéen (1928-1980), publie "L\'Enfant Noir" en 1953, récit autobiographique de son enfance en Guinée. L\'extrait proposé nous plonge dans l\'univers familial et artisanal de son père forgeron. Nous analyserons d\'abord le cadre évocateur, puis la relation père-fils, avant d\'étudier les valeurs culturelles exprimées.

**I. Un cadre évocateur et symbolique**
- Champ lexical de l\'intimité : "case", "véranda", "atelier"
- Oppositions : intérieur/extérieur, tradition/modernité
- La propreté ("très propre") témoigne d\'un respect sacré du lieu de travail

**II. Une relation père-fils forte**
- L\'enfant observe, admire, apprend
- Transmission orale et gestuelle du savoir
- Le père comme modèle et protecteur

**III. Les valeurs culturelles africaines**
- Importance de la famille et du clan
- Transmission des métiers de génération en génération
- Rapport au sacré (le père est initié)

### DISSERTATION

**Plan suggéré :**
- **I.** La littérature africaine comme miroir des réalités : colonisation, néocolonialisme, traditions (Mongo Beti, Ousmane Sembène)
- **II.** Mais la littérature est aussi création et interprétation subjective (Ahmadou Kourouma)
- **III.** La littérature africaine transcende la réalité pour atteindre l\'universel (Wole Soyinka)''',
    ),

    BacSubjectModel(
      id: 'bac_math_2023_C',
      subjectId: 'mathematiques',
      seriesId: 'C',
      year: 2023,
      session: 'Session 1',
      title: 'BAC 2023 – Mathématiques – Série C – Session 1',
      content: '''## SUJET DE MATHÉMATIQUES – BAC 2023 – Série C

**Durée : 4 heures | Coefficient : 7**

---

### EXERCICE 1 (5 points) : Suites numériques

Soit (uₙ) la suite définie par : u₀ = 1 et uₙ₊₁ = 2uₙ + 3 pour tout n ∈ ℕ.

1) Calculer u₁, u₂ et u₃.
2) Montrer que la suite (vₙ) définie par vₙ = uₙ + 3 est une suite géométrique dont on précisera la raison.
3) Exprimer vₙ puis uₙ en fonction de n.
4) Calculer lim uₙ quand n → +∞.

---

### EXERCICE 2 (5 points) : Probabilités

Une urne contient 5 boules rouges et 3 boules bleues. On tire successivement et sans remise deux boules.

1) Calculer la probabilité que les deux boules soient rouges.
2) Calculer la probabilité qu\'une boule soit rouge et l\'autre bleue.
3) Calculer la probabilité que les deux boules soient de la même couleur.

---

### PROBLÈME (10 points) : Étude de fonction

Soit f la fonction définie sur ℝ par f(x) = x³ - 3x + 2.

1) Calculer f\'(x) et étudier le signe de f\'(x).
2) Dresser le tableau de variations de f.
3) Déterminer les extrema locaux.
4) Calculer f(0), f(1), f(-2). Que remarquez-vous ?
5) Tracer la courbe de f dans un repère orthogonal.''',
      correction: '''## CORRIGÉ

### EXERCICE 1

1) u₁ = 2(1) + 3 = 5 ; u₂ = 2(5) + 3 = 13 ; u₃ = 2(13) + 3 = 29

2) vₙ = uₙ + 3
   v_{n+1} = u_{n+1} + 3 = 2uₙ + 3 + 3 = 2uₙ + 6 = 2(uₙ + 3) = 2vₙ
   
   Donc (vₙ) est géométrique de raison **q = 2** et v₀ = u₀ + 3 = 4.

3) vₙ = 4 × 2ⁿ = 2^(n+2)
   uₙ = vₙ - 3 = **2^(n+2) - 3**

4) Comme q = 2 > 1, vₙ → +∞, donc **lim uₙ = +∞**

### EXERCICE 2

n(Ω) = C(8,2) = 28

1) P(2 rouges) = C(5,2)/C(8,2) = 10/28 = **5/14**

2) P(1 rouge, 1 bleue) = C(5,1)×C(3,1)/C(8,2) = 15/28

3) P(même couleur) = P(2 rouges) + P(2 bleues)
   = 10/28 + C(3,2)/28 = 10/28 + 3/28 = **13/28**

### PROBLÈME

1) f\'(x) = 3x² - 3 = 3(x²-1) = 3(x-1)(x+1)
   f\'(x) > 0 si x < -1 ou x > 1 ; f\'(x) < 0 si -1 < x < 1

2) Tableau : croissant sur ]-∞,-1[, décroissant sur ]-1,1[, croissant sur ]1,+∞[

3) Maximum local en x = -1 : f(-1) = -1 + 3 + 2 = **4**
   Minimum local en x = 1 : f(1) = 1 - 3 + 2 = **0**

4) f(0) = 2 ; f(1) = 0 ; f(-2) = -8 + 6 + 2 = 0
   → x = 1 et x = -2 sont des racines de f ; factorisation : f(x) = (x-1)²(x+2)''',
    ),
  ];

  // ─── QUIZZES ─────────────────────────────────────────────────────────────────

  static Future<void> _seedQuizzes() async {
    final box = Hive.box<QuizModel>(AppConstants.quizzesBox);
    if (box.isNotEmpty) return;
    final quizzes = _buildQuizzes();
    for (final q in quizzes) {
      await box.put(q.id, q);
    }
  }

  static List<QuizModel> _buildQuizzes() => [
    // ── FRANÇAIS QUIZ ──
    QuizModel(
      id: 'quiz_fr_001',
      subjectId: 'francais',
      title: 'Figures de Style – Niveau Facile',
      description: 'Identifiez les principales figures de style du programme.',
      difficulty: 'Facile',
      timeLimitSeconds: 30,
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2'],
      questions: [
        QuizQuestion(
          id: 'q_fr_001',
          question: 'Quelle figure de style est utilisée dans cette phrase : "La vie est un long fleuve tranquille" ?',
          options: ['Métaphore', 'Comparaison', 'Hyperbole', 'Personnification'],
          correctIndex: 0,
          explanation: 'C\'est une MÉTAPHORE car la comparaison est implicite (sans "comme" ni "tel que"). La vie EST un fleuve, sans terme comparatif.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_002',
          question: 'Dans "Je meurs de faim !", quelle figure de style identifiez-vous ?',
          options: ['Litote', 'Hyperbole', 'Euphémisme', 'Antithèse'],
          correctIndex: 1,
          explanation: 'C\'est une HYPERBOLE : exagération expressive pour accentuer un sentiment ou une idée. On n\'est pas réellement en train de mourir.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_003',
          question: 'La répétition d\'un mot en début de plusieurs phrases consécutives s\'appelle :',
          options: ['Anaphore', 'Épiphore', 'Chiasme', 'Assonance'],
          correctIndex: 0,
          explanation: 'L\'ANAPHORE est la répétition d\'un même mot ou groupe de mots en début de phrases ou de vers successifs. Ex : "Rome, l\'unique objet de mon ressentiment ! Rome..."',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_004',
          question: 'Quel registre littéraire exprime des sentiments personnels intenses (amour, tristesse, nostalgie) ?',
          options: ['Épique', 'Lyrique', 'Comique', 'Tragique'],
          correctIndex: 1,
          explanation: 'Le registre LYRIQUE exprime les émotions et sentiments personnels du locuteur : amour, mélancolie, nostalgie. La poésie romantique est l\'exemple par excellence.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_005',
          question: 'Dans la dissertation, la problématique est :',
          options: [
            'Le résumé du sujet',
            'La question fondamentale soulevée par le sujet',
            'Le plan détaillé',
            'La conclusion de l\'introduction',
          ],
          correctIndex: 1,
          explanation: 'La problématique est la question centrale, profonde et précise que soulève le sujet. Elle guide tout le développement de la dissertation.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_006',
          question: '"Il n\'est pas très intelligent" pour dire qu\'il est stupide est un exemple de :',
          options: ['Hyperbole', 'Litote', 'Métaphore', 'Ironie'],
          correctIndex: 1,
          explanation: 'La LITOTE consiste à dire moins pour faire comprendre plus. Ici, "pas très intelligent" minimise pour suggérer l\'opposé.',
          difficulty: 'Moyen',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_007',
          question: 'Quel auteur africain a écrit "L\'Enfant Noir" (1953) ?',
          options: ['Mongo Beti', 'Ousmane Sembène', 'Camara Laye', 'Léopold Sédar Senghor'],
          correctIndex: 2,
          explanation: 'CAMARA LAYE (1928-1980), auteur guinéen, a écrit "L\'Enfant Noir", roman autobiographique qui décrit son enfance en Guinée et la relation avec son père forgeron.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_fr_008',
          question: 'Le commentaire de texte NE doit PAS :',
          options: [
            'Citer le texte avec précision',
            'Analyser les procédés stylistiques',
            'Raconter ce qui se passe dans le texte (paraphrase)',
            'Expliquer l\'effet produit sur le lecteur',
          ],
          correctIndex: 2,
          explanation: 'La PARAPHRASE est l\'erreur la plus fréquente : répéter ce qui est dit dans le texte sans l\'analyser. Le commentaire exige de l\'analyse, pas du résumé.',
          difficulty: 'Moyen',
          points: 1,
        ),
      ],
    ),

    // ── MATHÉMATIQUES QUIZ ──
    QuizModel(
      id: 'quiz_math_001',
      subjectId: 'mathematiques',
      title: 'Suites Numériques – QCM',
      description: 'Testez vos connaissances sur les suites arithmétiques et géométriques.',
      difficulty: 'Moyen',
      timeLimitSeconds: 45,
      seriesIds: ['C', 'D', 'G1', 'G2'],
      questions: [
        QuizQuestion(
          id: 'q_math_001',
          question: 'Une suite arithmétique de premier terme u₀ = 2 et de raison r = 4. Quelle est la valeur de u₅ ?',
          options: ['18', '20', '22', '24'],
          correctIndex: 2,
          explanation: 'uₙ = u₀ + n·r → u₅ = 2 + 5×4 = 2 + 20 = 22. On ajoute la raison 5 fois au premier terme.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_math_002',
          question: 'Pour une suite géométrique de raison q = 2 et u₀ = 3, la formule du terme général est :',
          options: ['uₙ = 3n + 2', 'uₙ = 3 × 2ⁿ', 'uₙ = 2 × 3ⁿ', 'uₙ = 3 + 2n'],
          correctIndex: 1,
          explanation: 'Pour une suite géométrique : uₙ = u₀ × qⁿ = 3 × 2ⁿ. On multiplie le premier terme par la raison élevée à la puissance n.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_math_003',
          question: 'La somme S = 1 + 2 + 3 + ... + 100 est égale à :',
          options: ['5000', '5050', '10000', '10100'],
          correctIndex: 1,
          explanation: 'Formule de Gauss : S = n(n+1)/2 = 100×101/2 = 5050. Cette suite arithmétique a 100 termes, premier terme 1, dernier terme 100.',
          difficulty: 'Moyen',
          points: 2,
        ),
        QuizQuestion(
          id: 'q_math_004',
          question: 'Si une suite (uₙ) vérifie uₙ₊₁ - uₙ = 5 pour tout n, alors la suite est :',
          options: [
            'Géométrique de raison 5',
            'Arithmétique de raison 5',
            'Géométrique de raison -5',
            'Ni arithmétique ni géométrique',
          ],
          correctIndex: 1,
          explanation: 'La différence uₙ₊₁ - uₙ = constante = 5 est la définition d\'une suite ARITHMÉTIQUE de raison r = 5.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_math_005',
          question: 'Dans le raisonnement par récurrence, l\'étape d\'hérédité consiste à :',
          options: [
            'Vérifier la propriété pour n = 0',
            'Supposer P(n) vraie et démontrer P(n+1)',
            'Calculer la limite de la suite',
            'Trouver le terme général',
          ],
          correctIndex: 1,
          explanation: 'L\'HÉRÉDITÉ suppose P(n) vraie (hypothèse de récurrence) et démontre que P(n+1) est alors également vraie. C\'est le cœur du raisonnement par récurrence.',
          difficulty: 'Moyen',
          points: 1,
        ),
      ],
    ),

    // ── SVT QUIZ ──
    QuizModel(
      id: 'quiz_svt_001',
      subjectId: 'svt',
      title: 'Division Cellulaire – Mitose & Méiose',
      description: 'Quiz sur les mécanismes de la mitose et de la méiose.',
      difficulty: 'Moyen',
      timeLimitSeconds: 40,
      seriesIds: ['C', 'D'],
      questions: [
        QuizQuestion(
          id: 'q_svt_001',
          question: 'Combien de cellules filles produit la mitose ?',
          options: ['1', '2', '4', '8'],
          correctIndex: 1,
          explanation: 'La mitose produit 2 cellules filles génétiquement identiques à la cellule mère, avec le même nombre de chromosomes (2n).',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_svt_002',
          question: 'À quelle phase de la mitose les chromosomes sont-ils les mieux visibles et alignés ?',
          options: ['Prophase', 'Métaphase', 'Anaphase', 'Télophase'],
          correctIndex: 1,
          explanation: 'La MÉTAPHASE est la phase où les chromosomes, au maximum de leur condensation, s\'alignent sur la plaque équatoriale. C\'est la phase utilisée pour établir le caryotype.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_svt_003',
          question: 'La méiose se déroule dans :',
          options: ['Toutes les cellules', 'Les cellules somatiques', 'Les gonades', 'Les cellules nerveuses'],
          correctIndex: 2,
          explanation: 'La méiose se déroule uniquement dans les GONADES (testicules et ovaires) pour produire les gamètes (spermatozoïdes et ovules).',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_svt_004',
          question: 'Le crossing-over (enjambement) se produit lors de :',
          options: ['La mitose', 'La prophase II de la méiose', 'La prophase I de la méiose', 'L\'interphase'],
          correctIndex: 2,
          explanation: 'Le crossing-over se produit lors de la PROPHASE I de la méiose, quand les chromosomes homologues échangent des segments. Il crée une diversité génétique (brassage interchromosomique).',
          difficulty: 'Moyen',
          points: 2,
        ),
        QuizQuestion(
          id: 'q_svt_005',
          question: 'Une cellule humaine (2n=46) après méiose donne des cellules avec :',
          options: ['46 chromosomes', '23 chromosomes', '92 chromosomes', '24 chromosomes'],
          correctIndex: 1,
          explanation: 'La méiose est réductionnelle : elle divise par 2 le nombre de chromosomes. 46/2 = 23 chromosomes. Ce sont des cellules haploïdes (n=23).',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_svt_006',
          question: 'La trisomie 21 est due à :',
          options: [
            'Une mutation génique',
            'Une non-disjonction lors de la méiose',
            'Un virus',
            'Un croisement de chromosomes',
          ],
          correctIndex: 1,
          explanation: 'La trisomie 21 (syndrome de Down) est causée par une NON-DISJONCTION lors de la méiose : les deux chromosomes 21 migrent dans la même cellule, créant une cellule à 3 chromosomes 21.',
          difficulty: 'Moyen',
          points: 2,
        ),
      ],
    ),

    // ── PHILOSOPHIE QUIZ ──
    QuizModel(
      id: 'quiz_philo_001',
      subjectId: 'philosophie',
      title: 'Notions de Philosophie – BAC',
      description: 'Les notions fondamentales du programme de philosophie.',
      difficulty: 'Difficile',
      timeLimitSeconds: 35,
      seriesIds: ['A1', 'A2', 'C', 'D', 'G1', 'G2'],
      questions: [
        QuizQuestion(
          id: 'q_philo_001',
          question: '"Je pense, donc je suis" est une formule de :',
          options: ['Platon', 'Aristote', 'René Descartes', 'Emmanuel Kant'],
          correctIndex: 2,
          explanation: 'DESCARTES (1596-1650) formule le Cogito dans les "Méditations Métaphysiques" (1641). C\'est la certitude première, fondement de sa philosophie rationaliste.',
          difficulty: 'Facile',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_philo_002',
          question: 'Pour Freud, l\'instance qui contient les pulsions refoulées est :',
          options: ['Le Moi', 'Le Surmoi', 'Le Ça', 'Le Préconscient'],
          correctIndex: 2,
          explanation: 'Le ÇA (Id) est le réservoir des pulsions et désirs inconscients refoulés. Il fonctionne selon le principe de plaisir et cherche la satisfaction immédiate.',
          difficulty: 'Moyen',
          points: 1,
        ),
        QuizQuestion(
          id: 'q_philo_003',
          question: 'L\'impératif catégorique de Kant signifie :',
          options: [
            'Agir selon ses désirs',
            'Agir selon une règle universalisable',
            'Obéir aux lois de l\'État',
            'Suivre ses émotions',
          ],
          correctIndex: 1,
          explanation: 'L\'impératif catégorique de KANT : "Agis de telle sorte que la maxime de ta volonté puisse toujours valoir comme principe d\'une législation universelle." C\'est la base de son éthique déontologique.',
          difficulty: 'Difficile',
          points: 2,
        ),
        QuizQuestion(
          id: 'q_philo_004',
          question: 'Selon Marx, la conscience est déterminée par :',
          options: [
            'La raison pure',
            'Les conditions matérielles d\'existence',
            'La religion',
            'Les gènes',
          ],
          correctIndex: 1,
          explanation: '"Ce n\'est pas la conscience qui détermine l\'être social, mais l\'être social qui détermine la conscience." (Marx) – Le matérialisme historique affirme que les conditions économiques façonnent notre pensée.',
          difficulty: 'Difficile',
          points: 2,
        ),
        QuizQuestion(
          id: 'q_philo_005',
          question: 'La philosophie existentialiste de Sartre affirme que :',
          options: [
            'L\'essence précède l\'existence',
            'L\'existence précède l\'essence',
            'Dieu détermine notre essence',
            'La nature détermine l\'être humain',
          ],
          correctIndex: 1,
          explanation: '"L\'existence précède l\'essence" (Sartre) : l\'être humain n\'a pas de nature prédéfinie. Il se crée lui-même par ses actes et ses choix. Il est condamné à être libre.',
          difficulty: 'Difficile',
          points: 2,
        ),
      ],
    ),
  ];
}
