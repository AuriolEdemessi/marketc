class Status{
  String? lead;
  String? sub;
  Status({this.lead, this.sub});

  @override
  String toString() {
    return 'Status{lead: $lead, sub: $sub}';
  }
}

Status statusCompte(int? statut){
  late Status status;
  switch (statut) {
    case 1:
       status =  Status(lead:"Vérification en cours", sub:"Accès client limité");
      break;
    case 2:
       status =  Status(lead:"Vérification terminé", sub:"Accès client illimité");
      break;
    case 3:
       status =  Status(lead:"Vérification en cours", sub:"Accès revendeur limité");
       break;
    case 4:
      status =  Status(lead:"Vérification terminé", sub:"Accès revendeur illimité");
      break;
    case 5:
      status =  Status(lead:"Vérification rejecté", sub:"Reprendre la verification client");
      break;
    case 6:
      status =  Status(lead:"Vérification rejecté", sub:"Reprendre la verification revendeur");
      break;
    default:
      status =  Status(lead:"Compte non verifié", sub:"Accès strictement limité");
      break;
  }
  return status;
}