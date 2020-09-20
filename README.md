<a href="https://terraform.io">
    <img src="https://cdn.rawgit.com/hashicorp/terraform-website/master/content/source/assets/images/logo-hashicorp.svg" alt="Terraform logo" title="Terraform" align="right" height="50" />
</a>

# TP 1 : Terraform

- [Prérequis](#prérequis)
- [Aperçu de l'application](#aperçu-de-lapplication)
- [Références](#références)
- [Buts du projet](#buts-du-projet)
- [Procédure](#procédure)
- [Architecture finale simplifiée](#architecture-finale-simplifiée)

## Prérequis
- Avoir un compte AWS
- Avoir une générer une clé dont le nom est **_aws-upec_**
- Avoir créé un utilisateur avec les droits d'admin sur son compte AWS
- Exporter les AWS_ACCESS_KEY_ID et AWS_SECRET_ACCESS_KEY de cette utilisateur sur votre machine
```
export AWS_ACCESS_KEY_ID="AXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="JXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```
- Exporter les variables pour les logs 
```
export TF_LOG="INFO"
export TF_LOG_PATH="terraform.log"
```

## Aperçu de l'application
L'application est disponible à l'URL suivante : 
- http://176.34.85.71/

Si vous ne voyez aucune donnée, vous pouvez charger des données en vous rendant à l'adresse suivante : 
- http://176.34.85.71/feed

Ensuite vous pouvez revenir à l'URL suivante :
- http://176.34.85.71/


## Références
- https://blog.octo.com/creer-des-instances-aws-qui-ont-acces-a-internet-sans-ip-publique-avec-terraform/
- https://learn.hashicorp.com/collections/terraform/aws-get-started#getting-started


## Buts du projet
- Créer des ressources sur AWS à l'aide de terraform
- Créer des réseaux différents (publics et privés)
- Déployer des applications sur les machines appartenant à différents réseaux
- Déployer un controller NodeJS permettant de récupérer et sauvegarder des données dans une base de données MongoDB


## Procédure
1. Cloner ce repository (sur une machine linux de préférence)
2. Se placer dans le repository
```
cd terraform
```
3. Lancer le fichier terraform_init.sh avec la commande suivante :
```
sh scripts/terraform_init.sh
```
3. Pour supprimer les ressources créées avec terraform, lancer le fichier terraform_destroy.sh avec la commande suivante :
```
sh scripts/terraform_destroy.sh
```


## Architecture finale simplifiée
![Architecture finale simplifiée](images/architecture.png?raw=true "Architecture finale simplifiée")