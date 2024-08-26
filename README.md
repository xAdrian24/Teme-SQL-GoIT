# Tema-1-SQL

1.Conectează-te la baza de date folosind accesul care ți-a fost dat.
2.Găsește tabelul facebook_ads_basic_daily și familiarizează-te cu coloanele.
3.Scrie o interogare SQL care să selecteze câmpurile ad_date, spend, clicks și raportul spend/clicks.
4.Adaugă la interogare o condiție conform căreia numărul de click-uri trebuie să fie mai mare decât zero.
5.Sortează tabelul rezultat după câmpul ad_date în ordine descrescătoare.
6.Încarcă în formularul de predare a temei fișierul SQL cu interogarea rezultată.  


# Tema-2-SQL

Scrie o interogare SQL care să selecteze următoarele date din tabelul facebook_ads_basic_daily:
ad_date - data afișării reclamei.
campaign_id - identificatorul unic al campaniei.
valori agregate în funcție de data și de id-ul campaniei pentru următorii indicatori:
cost total
numărul de impresii
numărul de click-uri
valoarea totală a conversiei
Utilizând cifrele agregate privind costurile și conversia, calculează următorii indicatori pentru fiecare dată și id de campanie:
CPC
CPM
CTR
ROMI
Pentru a efectua această sarcină, grupează tabelul în funcție de câmpurile ad_date și campaign_id.

# Tema-2-BONUS-SQL 
Dintre campaniile cu o cheltuială totală de peste 500 000 din tabelul facebook_ads_basic_daily, găsește campania cu cel mai mare ROMI.
Rezultatul sarcinii

A fost găsit ID-ul campaniei cu cel mai mare ROMI.
Interogarea este executată și returnează rezultatul necesar.

# Tema-3-SQL

Într-o interogare SQL în CTE, combină datele din tabelele date pentru a obține:
ad_date - data afișării reclamei pe Google și Facebook.
campaign_name - numele campaniei pe Google și Facebook.
spend, impressions, reach, clicks, leads, value - metricile campaniilor și ale seturilor de reclame în zilele respective.
În mod similar cu sarcina din subiectul anterior, efectuează o selecție din tabelul combinat (CTE) rezultat:

ad_date- data afișării reclamei
campaign_name - numele campaniei
valorile agregate pentru următorii indicatori în funcție de dată și de id-ul campaniei:
total cost,
numărul de impresii,
numărul de click-uri,
valoarea totală a conversiei.
Pentru a efectua această sarcină, grupează tabelul după câmpurile ad_date și campaign_name.

# Tema-3-BONUS-SQL 
Combinând datele din cele patru tabele, găsește campania cu cel mai mare ROMI dintre toate campaniile cu o cheltuială totală mai mare de 500 000.
În cadrul acestei campanii, identifică grupul de reclame (adset_name) cu cel mai mare ROMI.
Rezultatul sarcinii

A fost găsită denumirea campaniei cu cel mai mare ROMI.
Interogarea este executată și returnează rezultatul necesar.

# Tema-4-SQL

În Google Looker Studio, creează un nou raport și configurează sursa de date:
Selectează PostgreSQL ca sursă de date;
Conectează-te la DB din sarcinile anterioare;
Selectează opțiunea “custom query” (interogare personalizată) și utilizează interogarea din tema de la Subiectul 3.
Creează noi câmpuri în raport:
Totalul Ad Spend
CPC
CPM
CTR
ROMI
Adaugă trei diagrame (chart) în dashboard:
O diagramă combinată cu data afișării reclamei pe axa orizontală și totalul Ad Spend și ROMI pentru fiecare lună pe două axe verticale. Axa orizontală trebuie să fie ordonată de la cea mai veche dată la cea mai recentă.
O diagramă liniară cu numărul de campanii active în fiecare lună de afișare a reclamelor.
Un tabel cu coloane și heatmaps, în care denumirea campaniei este setată ca dimension, iar totalul Ad Spend, CPC, CPM, CTR, ROMI sunt setate ca metrici.
Adaugă în raport filtre pentru denumirea campaniilor și pentru data afișării reclamelor.

# Tema-5-SQL

Într-o interogare CTE, combină datele din tabelele de mai sus pentru a obține:
ad_date - data afișării reclamei pe Google și Facebook
url_parameters - o parte din URL-ul din link-ul campaniei care conține parametrii UTM.
spend, impresions, impresions, reach, clicks, leads, value - metrici ale campaniilor și seturilor de reclame în zilele respective.
!!! În cazul în care în tabel metricele nu are valoare (adică este null), setează valoarea la zero (adică 0).

Din CTE-ul obținut, realizează un sondaj:
ad_date - data reclamei.
utm_campaign - valoarea parametrului utm_campaign din câmpul utm_parameters care îndeplinește următoarele condiții:
este redusă la litere mici;
dacă valoarea lui utm_campaign din utm_parameters este egală cu "nan", atunci trebuie să fie goală (adică null) în tabelul rezultat.


Suma totală a cheltuielilor, numărul de afișări, numărul de click-uri, precum și valoarea totală a conversiilor într-o anumită dată pentru o anumită campanie.
CTR, CPC, CPM, ROMI într-o anumită dată pentru o anumită campanie.
!!! În același timp, nu folosi WHERE, ci evită eroarea de împărțire la zero prin utilizarea operatorului CASE.

# Tema-5-BONUS-SQL 
În interogarea pe care ai creat-o pentru sarcina principală a acestei teme, decodează valoarea lui utm_campaign prin crearea unei funcții temporare. Găsește codul funcției pe internet.

Rezultatul sarcinii

Încarcă fișierul SQL cu interogarea scrisă în formularul de predare a temei pentru acasă.

# Tema-6-SQL

Folosește CTE din tema anterioară într-un nou (al doilea) CTE pentru a crea un eșantion cu următoarele date:
ad_month - prima zi a lunii datei de afișare a reclamelor. (obținută din ad_date);
utm_campaign, cost total cheltuiele, număr de impresii, număr de click-uri, valoare de conversie, CTR, CPC, CPM, ROMI — aceleași câmpuri cu aceleași condiții ca în tema anterioară.
Realizează selecția rezultată cu următoarele câmpuri:
ad_month;
utm_campaign, cost total cheltuiele, număr de impresii, număr de click-uri, valoare de conversie, CTR, CPC, CPM, ROMI.
Pentru fiecare utm_campaign, adaugă un câmp nou în fiecare lună: diferența dintre CPM, CTR și ROMI în luna curentă față de luna anterioară, exprimată în procente.

# Tema-7-SQL
BIGQuery |  Google Analytics 4 

Sarcina 1. Pregătirea datelor pentru crearea rapoartelor în sistemele BI
Creează o interogare pentru a obține un tabel cu informații despre evenimente, utilizatori și sesiuni în GA4. Ca rezultat al executării interogării, trebuie să obținem un tabel care să includă următoarele câmpuri:

event_timestamp - data și ora evenimentului (tipul de date trebuie să fie timestamp);
user_pseudo_id - identificatorul anonim al utilizatorului în GA4;
session_id - identificatorul sesiunii evenimentului în GA4;
event_name - numele evenimentului;
country - țara utilizatorului site-ului.;
device_category - categoria de dispozitiv a utilizatorului site-ului;
source - sursa vizitei site-ului
medium - mediul de vizitare a site-ului
campaign - numele campaniei de vizitare a site-ului
Tabelul trebuie să includă numai date pentru anul 2021 și date din următoarele evenimente:

Începutul sesiunii pe site
Vizualizarea unui produs
Adăugarea unui produs în coș
Începerea procesului de achiziție
Adăugarea informațiilor privind livrarea
Adăugarea informațiilor de plată
Verificarea comenzii

Sarcina 2. Calcularea conversiilor în funcție de date și canale de trafic
Creează o interogare pentru a obține un tabel cu informații despre conversii de la începutul sesiunii până la achiziție. Tabelul rezultat ar trebui să includă următoarele câmpuri:

event_date - data de început a sesiunii, obținută din câmpul event_timestamp;
source - sursa vizitei pe site;
medium - mediul de vizitare a site-ului;
campaign - numele campaniei de vizitare a site-ului;
user_sessions_count - numărul de sesiuni unice pentru utilizatorii unici la data corespunzătoare și pentru canalul de trafic corespunzător;
visit_to_cart - conversia de la începutul sesiunii pe site până la adaugarea produselor în coș (la data respectivă și pentru canalul de trafic corespunzător);
visit_to_checkout - conversia de la începutul sesiunii pe site până la încercarea de a finaliza comanda (la data respectivă și pentru canalul de trafic corespunzător);
visit_to_purchase - conversia de la începutul sesiunii pe site până la achiziție (la data respectivă și pentru canalul de trafic corespunzător)
Notă

Sarcina 3. Compararea ratelor de conversie între diferite landing pages
Pentru a finaliza această sarcină, va trebui să obții page path (calea către pagină fără adresa domeniului și fără parametrii de link) din page_location în evenimentul de început al sesiunii.

Pentru fiecare pagină unică de pornire a sesiunii, calculează următorii parametri pe baza datelor din 2020:

Numărul de sesiuni unice per utilizator unic;
Numărul de achiziții;
Conversia de la începutul sesiunii până la achiziție.

Sarcina 4. Verificarea corelației dintre implicarea utilizatorului și achiziție
Pentru fiecare sesiune unică, determină:

Dacă utilizatorul a fost implicat în timpul acestei sesiuni (dacă valoarea parametrului session_engaged = 1)
Timpul total de activitate al utilizatorului în timpul sesiunii (suma parametrului engagement_time_msec din fiecare eveniment al sesiunii).
Dacă achiziția a fost efectuată în timpul sesiunii.
Calculează valoarea coeficientului de corelație:

între p.1 și p.3
între p.2 și p.3
