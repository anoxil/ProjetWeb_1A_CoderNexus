-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  jeu. 29 mars 2018 à 06:18
-- Version du serveur :  10.1.31-MariaDB
-- Version de PHP :  7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `codernexus`
--

-- --------------------------------------------------------

--
-- Structure de la table `comptes`
--

/*
  Cette table contient les profil de chaque utilisateur inscrit.
  Ce dernier peut modifier ses informations sur la page modifierCompte.php.
  Lors de l'inscription, nous vérifions qu'un compte avec le même login et/ou
  la même adresse mail n'existe pas déjà. La colonne admin permet d'accéder 
  aux fonctionnalités supérieures si la valeur est de 1. Cependant il est
  pour l'instant nécessaire de réaliser une requête SQL depuis phpMyAdmin
  pour accéder à ces privilèges. */
CREATE TABLE `comptes` (
  `ID` int(20) NOT NULL,
  `LOGIN_USER` varchar(50) NOT NULL,
  `NOM` varchar(50) NOT NULL,
  `PRENOM` varchar(50) NOT NULL,
  `MAIL` varchar(50) NOT NULL,
  `MDP` varchar(50) NOT NULL,
  `ADMIN` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `comptes`
--

-- Ici seul le compte admin/admin est considéré comme administrateur (ADMIN=1)
INSERT INTO `comptes` (`ID`, `LOGIN_USER`, `NOM`, `PRENOM`, `MAIL`, `MDP`, `ADMIN`) VALUES
(8, 'admin', 'von Neumann', 'John', '1337h4x0r@wanadoo.fr', 'admin', 1),
(12, 'anoxil', 'Brès', 'Raphaël', 'rbres@ensc.fr', 'anoxil', 0),
(13, 'mtriscos', 'Triscos', 'Margot', 'mtriscos@ensc.fr', 'mtriscos', 0);

-- --------------------------------------------------------

--
-- Structure de la table `langages`
--

/*
  Table contenant tous les langages supportés par le site. Lors de l'ajout d'un
  tutoriel, l'administrateur aura le choix parmi la liste de langages suivants.
  Une colonne spéciale IMAGE a été créée car certains noms de langage contiennent
  des caractères spéciaux rendant la génération PHP de chemin relatif impossible.
  Le TYPE n'est la plupart du temps qu'un seul des paradigmes proposés par le
  langage ; une des pistes d'améliorations est de lier plusieurs paradigmes à
  un seul langage.
*/
CREATE TABLE `langages` (
  `ID` int(20) NOT NULL,
  `LANGAGE` varchar(20) NOT NULL,
  `TYPE` varchar(50) NOT NULL,
  `IMAGE` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `langages`
--

-- 23 langages rajoutés pour l'instant
INSERT INTO `langages` (`ID`, `LANGAGE`, `TYPE`, `IMAGE`) VALUES
(1, 'Bootstrap', 'Framework d\'interface', 'bootstrap'),
(2, 'C', 'Programmation impérative', 'c'),
(3, 'C++', 'Programmation orientée objet', 'cpp'),
(4, 'C#', 'Programmation orientée objet', 'csharp'),
(5, 'Django', 'Framework web', 'django'),
(6, 'Go', 'Programmation impérative', 'go'),
(7, 'Haskell', 'Programmation fonctionnelle', 'haskell'),
(8, 'HTML', 'Langage de balisage', 'html'),
(9, 'Java', 'Programmation orientée objet', 'java'),
(10, 'JavaScript', 'Programmation web', 'javascript'),
(11, 'JQuery', 'Framework web', 'jquery'),
(12, 'Latex', 'Langage de balisage', 'latex'),
(13, 'Lua', 'Langage procédural', 'lua'),
(14, 'MySQL', 'Programmation déclarative', 'mysql'),
(15, 'Ruby', 'Programmation orientée objet', 'ruby'),
(16, 'Perl', 'Programmation impérative', 'perl'),
(17, 'PHP', 'Programmation web', 'php'),
(18, 'Python', 'Programmation orientée objet', 'python'),
(19, 'R', 'Programmation impérative', 'r'),
(20, 'CSS', 'Langage de style', 'css'),
(21, 'Scala', 'Programmation fonctionnelle', 'scala'),
(22, 'Symfony', 'Framework web', 'symfony'),
(23, 'Prolog', 'Programmation logique', 'prolog');

-- --------------------------------------------------------

--
-- Structure de la table `participations`
--

/*
  Contient toutes les indications des utilisateurs comme
  participant/ayant participé à un tutoriel donné. Ces informations
  sont utilisées afin de "bookmarker" les tutoriels sur le profil
  d'un utilisateur.
*/
CREATE TABLE `participations` (
  `ID` int(30) NOT NULL,
  `ID_USER` int(20) NOT NULL,
  `ID_TUTORIAL` int(10) NOT NULL,
  `ETAT` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `participations`
--

-- Quelques données pré-remplie pour les utilisateurs 8(admin) et 12(anoxil)
INSERT INTO `participations` (`ID`, `ID_USER`, `ID_TUTORIAL`, `ETAT`) VALUES
(21, 8, 5, 1),
(22, 8, 10, 0),
(23, 8, 9, 1),
(24, 8, 45, 0),
(25, 8, 15, 0),
(28, 12, 9, 0),
(29, 12, 13, 1),
(30, 12, 16, 0),
(31, 12, 20, 0),
(32, 12, 19, 1),
(35, 12, 17, 1);

-- --------------------------------------------------------

--
-- Structure de la table `tutoriels`
--

/*
  Table contenant les tutoriels ajoutés par les administrateurs.
  La colonne DATE n'est pas obligatoirement remplissable, dans le
  cas d'un tutoriel mal présenté. Le NIVEAU est une estimation
  arbitraire, mais basée sur l'expérience, du tutoriel.
*/
CREATE TABLE `tutoriels` (
  `ID` int(10) NOT NULL,
  `LANGAGE` varchar(20) NOT NULL,
  `INTITULE` varchar(100) NOT NULL,
  `LIEN` varchar(100) NOT NULL,
  `DATE` date NOT NULL,
  `NIVEAU` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tutoriels`
--

-- 26 tutoriels déjà pré-remplis
INSERT INTO `tutoriels` (`ID`, `LANGAGE`, `INTITULE`, `LIEN`, `DATE`, `NIVEAU`) VALUES
(5, 'C++', 'Programmez avec le langage C++', 'https://openclassrooms.com/courses/programmez-avec-le-langage-c', '2017-11-23', 4),
(6, 'C++', 'Bien débuter en C++', 'http://alp.developpez.com/tutoriels/debuter-cpp/', '2012-08-24', 1),
(7, 'C++', 'Débuter en C++ moderne', 'http://guillaume.belz.free.fr/doku.php?id=programmez_avec_le_langage_c', '2017-10-19', 2),
(8, 'Latex', 'Formation LaTeX', 'http://konflor.developpez.com/tutoriels/latex/formation/', '2014-11-11', 2),
(9, 'Python', 'Apprenez à programmer en Python', 'https://openclassrooms.com/courses/apprenez-a-programmer-en-python', '2017-11-17', 1),
(10, 'Python', 'Complete Python Bootcamp: Go from zero to hero in Python 3', 'https://www.udemy.com/complete-python-bootcamp/', '2018-03-01', 3),
(11, 'Haskell', 'Advanced Haskell', 'https://www.schoolofhaskell.com/school/advanced-haskell', '0000-00-00', 5),
(13, 'Haskell', 'Haskell ? C\'est quoi ?', 'https://openclassrooms.com/courses/apprenez-la-programmation-fonctionnelle-avec-haskell/haskell-c-es', '2013-12-05', 2),
(14, 'Haskell', 'Apprendre Haskell vous fera le plus grand bien !', 'http://lyah.haskell.fr/introduction', '0000-00-00', 2),
(15, 'JQuery', 'jQuery Tutorial', 'https://www.w3schools.com/jquery/default.asp', '0000-00-00', 3),
(16, 'JQuery', 'jQuery Tutorial - An Ultimate Guide for Beginners', 'https://www.tutorialrepublic.com/jquery-tutorial/', '2014-09-06', 2),
(17, 'Bootstrap', 'A Simple Bootstrap Tutorial', 'https://www.toptal.com/front-end/what-is-bootstrap-a-short-tutorial-on-the-what-why-and-how', '2015-03-04', 1),
(18, 'Ruby', 'Apprenez Ruby', 'https://ruby-doc.org/docs/beginner-fr/xhtml/', '2003-05-23', 2),
(19, 'Ruby', 'Lancez-vous dans la programmation avec Ruby', 'https://openclassrooms.com/courses/lancez-vous-dans-la-programmation-avec-ruby', '2017-08-16', 1),
(20, 'Prolog', 'Introduction à PROLOG', 'https://perso.liris.cnrs.fr/christine.solnon/prolog.html', '1997-02-13', 4),
(21, 'HTML', 'HTML-Structurer le Web', 'https://developer.mozilla.org/fr/Apprendre/HTML', '2018-03-05', 1),
(22, 'HTML', 'Advanced HTML Tutorial', 'http://www.freewebmasterhelp.com/tutorials/html-advanced', '2001-06-03', 3),
(23, 'Symfony', 'Symfony Tutorial: Building a Blog', 'https://auth0.com/blog/symfony-tutorial-building-a-blog-part-1/', '2017-12-28', 3),
(24, 'C#', 'An advanced introduction to C#', 'https://www.codeproject.com/Articles/1094079/An-advanced-introduction-to-Csharp-Lecture-Notes-P', '2016-10-03', 4),
(25, 'C#', 'Didacticiels interactifs pour C#', 'https://docs.microsoft.com/fr-fr/dotnet/csharp/quick-starts/', '2018-01-30', 3),
(26, 'C#', 'Apprenez à développer en C#', 'https://openclassrooms.com/courses/apprenez-a-developper-en-c', '2017-08-14', 2),
(27, 'Django', 'Getting started with Django', 'https://www.djangoproject.com/start/', '0000-00-00', 2),
(28, 'Django', 'Welcome to Advanced Django Training', 'https://django-advanced-training.readthedocs.io/en/latest/', '2017-09-23', 3),
(45, 'Go', 'A Tour of Go', 'https://tour.golang.org/welcome/1', '0000-00-00', 2),
(49, 'JavaScript', 'Apprenez à coder avec JavaScript', 'https://openclassrooms.com/courses/apprenez-a-coder-avec-javascript', '2018-01-16', 2),
(50, 'Python', 'A Python 3 programming tutorial for beginners. ', 'https://github.com/Akuli/python-tutorial', '2018-01-05', 1);

-- --------------------------------------------------------

--
-- Structure de la table `votes`
--

/*
  Un utilisateur lorsqu'il est inscrit a la possibilité de voter pour
  chaque tutoriel (un seul vote changeable). Dans cette table nous
  stockons tous les votes de chaque utilisateur : nous devons donc
  enregistrer l'id de l'utilisateur, son vote /5 et le tutoriel visé.
  On peut ensuite faire une moyenne des votes pour un tuto afin
  d'estimer sa popularité.
*/
CREATE TABLE `votes` (
  `ID` int(30) NOT NULL,
  `ID_USER` int(20) NOT NULL,
  `VOTE_USER` int(3) NOT NULL,
  `ID_TUTORIAL` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `votes`
--

-- Chaque compte déjà créé a déjà quelques votes de pré-inscrits.
INSERT INTO `votes` (`ID`, `ID_USER`, `VOTE_USER`, `ID_TUTORIAL`) VALUES
(22, 8, 3, 9),
(25, 8, 5, 5),
(26, 8, 4, 45),
(28, 12, 1, 10),
(29, 13, 2, 10),
(30, 8, 4, 15),
(45, 8, 2, 10),
(46, 12, 4, 45),
(47, 12, 2, 13),
(48, 12, 4, 19),
(49, 8, 3, 50),
(55, 12, 3, 17),
(56, 12, 3, 5);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `langages`
--
ALTER TABLE `langages`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `participations`
--
ALTER TABLE `participations`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `participations_ibfk_1` (`ID_TUTORIAL`),
  ADD KEY `participations_ibfk_2` (`ID_USER`);

--
-- Index pour la table `tutoriels`
--
ALTER TABLE `tutoriels`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `votes_ibfk_1` (`ID_USER`),
  ADD KEY `votes_ibfk_2` (`ID_TUTORIAL`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `comptes`
--
ALTER TABLE `comptes`
  MODIFY `ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `langages`
--
ALTER TABLE `langages`
  MODIFY `ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `participations`
--
ALTER TABLE `participations`
  MODIFY `ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT pour la table `tutoriels`
--
ALTER TABLE `tutoriels`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `votes`
--
ALTER TABLE `votes`
  MODIFY `ID` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `participations`
-- 

-- Quelques clés étrangères pour faire la liaison entre chaque table
ALTER TABLE `participations`
  ADD CONSTRAINT `participations_ibfk_1` FOREIGN KEY (`ID_TUTORIAL`) REFERENCES `tutoriels` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `participations_ibfk_2` FOREIGN KEY (`ID_USER`) REFERENCES `comptes` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`ID_USER`) REFERENCES `comptes` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`ID_TUTORIAL`) REFERENCES `tutoriels` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
