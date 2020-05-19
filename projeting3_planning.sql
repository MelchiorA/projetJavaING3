-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  sam. 16 mai 2020 à 13:44
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `projeting3_planning`
--

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `enseignant`
--

DROP TABLE IF EXISTS `enseignant`;
CREATE TABLE IF NOT EXISTS `enseignant` (
  `ID_utilisateur` int(11) NOT NULL,
  `ID_cours` int(11) NOT NULL,
  PRIMARY KEY (`ID_utilisateur`,`ID_cours`),
  KEY `donne_cours` (`ID_cours`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `ID_utilisateur` int(11) NOT NULL,
  `Numero` int(11) NOT NULL,
  `ID_groupe` int(11) NOT NULL,
  PRIMARY KEY (`ID_utilisateur`),
  KEY `appartient_a` (`ID_groupe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
CREATE TABLE IF NOT EXISTS `groupe` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(32) NOT NULL,
  `ID_Promotion` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
CREATE TABLE IF NOT EXISTS `promotion` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

DROP TABLE IF EXISTS `salle`;
CREATE TABLE IF NOT EXISTS `salle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(16) NOT NULL,
  `Capacite` int(11) NOT NULL,
  `ID_site` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `est_situee` (`ID_site`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

DROP TABLE IF EXISTS `seance`;
CREATE TABLE IF NOT EXISTS `seance` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `semaine` int(11) NOT NULL,
  `date` date NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  `etat` int(11) NOT NULL,
  `ID_cours` int(11) NOT NULL,
  `ID_type` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `est_un_cours_de` (`ID_cours`),
  KEY `est_de_type` (`ID_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `seance_enseignants`
--

DROP TABLE IF EXISTS `seance_enseignants`;
CREATE TABLE IF NOT EXISTS `seance_enseignants` (
  `ID_seance` int(11) NOT NULL,
  `ID_enseignant` int(11) NOT NULL,
  PRIMARY KEY (`ID_seance`,`ID_enseignant`),
  KEY `est_dispensee_par` (`ID_enseignant`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `seance_groupes`
--

DROP TABLE IF EXISTS `seance_groupes`;
CREATE TABLE IF NOT EXISTS `seance_groupes` (
  `ID_seance` int(11) NOT NULL,
  `ID_groupe` int(11) NOT NULL,
  PRIMARY KEY (`ID_seance`,`ID_groupe`),
  KEY `assiste_a` (`ID_groupe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `seance_salles`
--

DROP TABLE IF EXISTS `seance_salles`;
CREATE TABLE IF NOT EXISTS `seance_salles` (
  `ID_seance` int(11) NOT NULL,
  `ID_salle` int(11) NOT NULL,
  PRIMARY KEY (`ID_seance`,`ID_salle`),
  KEY `ID_salle` (`ID_salle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `site`
--

DROP TABLE IF EXISTS `site`;
CREATE TABLE IF NOT EXISTS `site` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `type_cours`
--

DROP TABLE IF EXISTS `type_cours`;
CREATE TABLE IF NOT EXISTS `type_cours` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `passwd` varchar(64) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `droit` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD CONSTRAINT `donne_cours` FOREIGN KEY (`ID_cours`) REFERENCES `cours` (`ID`),
  ADD CONSTRAINT `est_un` FOREIGN KEY (`ID_utilisateur`) REFERENCES `utilisateur` (`ID`);

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `appartient_a` FOREIGN KEY (`ID_groupe`) REFERENCES `groupe` (`ID`),
  ADD CONSTRAINT `est` FOREIGN KEY (`ID_utilisateur`) REFERENCES `utilisateur` (`ID`);

--
-- Contraintes pour la table `salle`
--
ALTER TABLE `salle`
  ADD CONSTRAINT `est_situee` FOREIGN KEY (`ID_site`) REFERENCES `site` (`ID`);

--
-- Contraintes pour la table `seance`
--
ALTER TABLE `seance`
  ADD CONSTRAINT `est_de_type` FOREIGN KEY (`ID_type`) REFERENCES `type_cours` (`ID`),
  ADD CONSTRAINT `est_un_cours_de` FOREIGN KEY (`ID_cours`) REFERENCES `cours` (`ID`);

--
-- Contraintes pour la table `seance_enseignants`
--
ALTER TABLE `seance_enseignants`
  ADD CONSTRAINT `est_dispensee_par` FOREIGN KEY (`ID_enseignant`) REFERENCES `enseignant` (`ID_utilisateur`),
  ADD CONSTRAINT `est_une` FOREIGN KEY (`ID_seance`) REFERENCES `seance` (`ID`);

--
-- Contraintes pour la table `seance_groupes`
--
ALTER TABLE `seance_groupes`
  ADD CONSTRAINT `assiste_a` FOREIGN KEY (`ID_groupe`) REFERENCES `groupe` (`ID`),
  ADD CONSTRAINT `seance_de` FOREIGN KEY (`ID_seance`) REFERENCES `seance` (`ID`);

--
-- Contraintes pour la table `seance_salles`
--
ALTER TABLE `seance_salles`
  ADD CONSTRAINT `is_a` FOREIGN KEY (`ID_seance`) REFERENCES `seance` (`ID`),
  ADD CONSTRAINT `situee_a` FOREIGN KEY (`ID_salle`) REFERENCES `salle` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
