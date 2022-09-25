import 'dart:convert';

import 'api_client.dart';
import 'endpoint.dart';
import '../models/models.dart';

final _countries = """
{
    "get": "countries",
    "parameters": [],
    "errors": [],
    "results": 164,
    "paging": {
        "current": 1,
        "total": 1
    },
    "response": [
        {
            "name": "Albania",
            "code": "AL",
            "flag": "https://media.api-sports.io/flags/al.svg"
        },
        {
            "name": "Algeria",
            "code": "DZ",
            "flag": "https://media.api-sports.io/flags/dz.svg"
        },
        {
            "name": "Andorra",
            "code": "AD",
            "flag": "https://media.api-sports.io/flags/ad.svg"
        },
        {
            "name": "Angola",
            "code": "AO",
            "flag": "https://media.api-sports.io/flags/ao.svg"
        },
        {
            "name": "Argentina",
            "code": "AR",
            "flag": "https://media.api-sports.io/flags/ar.svg"
        },
        {
            "name": "Armenia",
            "code": "AM",
            "flag": "https://media.api-sports.io/flags/am.svg"
        },
        {
            "name": "Aruba",
            "code": "AW",
            "flag": "https://media.api-sports.io/flags/aw.svg"
        },
        {
            "name": "Australia",
            "code": "AU",
            "flag": "https://media.api-sports.io/flags/au.svg"
        },
        {
            "name": "Austria",
            "code": "AT",
            "flag": "https://media.api-sports.io/flags/at.svg"
        },
        {
            "name": "Azerbaidjan",
            "code": "AZ",
            "flag": "https://media.api-sports.io/flags/az.svg"
        },
        {
            "name": "Bahrain",
            "code": "BH",
            "flag": "https://media.api-sports.io/flags/bh.svg"
        },
        {
            "name": "Bangladesh",
            "code": "BD",
            "flag": "https://media.api-sports.io/flags/bd.svg"
        },
        {
            "name": "Barbados",
            "code": "BB",
            "flag": "https://media.api-sports.io/flags/bb.svg"
        },
        {
            "name": "Belarus",
            "code": "BY",
            "flag": "https://media.api-sports.io/flags/by.svg"
        },
        {
            "name": "Belgium",
            "code": "BE",
            "flag": "https://media.api-sports.io/flags/be.svg"
        },
        {
            "name": "Belize",
            "code": "BZ",
            "flag": "https://media.api-sports.io/flags/bz.svg"
        },
        {
            "name": "Benin",
            "code": "BJ",
            "flag": "https://media.api-sports.io/flags/bj.svg"
        },
        {
            "name": "Bermuda",
            "code": "BM",
            "flag": "https://media.api-sports.io/flags/bm.svg"
        },
        {
            "name": "Bhutan",
            "code": "BT",
            "flag": "https://media.api-sports.io/flags/bt.svg"
        },
        {
            "name": "Bolivia",
            "code": "BO",
            "flag": "https://media.api-sports.io/flags/bo.svg"
        },
        {
            "name": "Bosnia",
            "code": "BA",
            "flag": "https://media.api-sports.io/flags/ba.svg"
        },
        {
            "name": "Botswana",
            "code": "BW",
            "flag": "https://media.api-sports.io/flags/bw.svg"
        },
        {
            "name": "Brazil",
            "code": "BR",
            "flag": "https://media.api-sports.io/flags/br.svg"
        },
        {
            "name": "Bulgaria",
            "code": "BG",
            "flag": "https://media.api-sports.io/flags/bg.svg"
        },
        {
            "name": "Burkina-Faso",
            "code": "BF",
            "flag": "https://media.api-sports.io/flags/bf.svg"
        },
        {
            "name": "Burundi",
            "code": "BI",
            "flag": "https://media.api-sports.io/flags/bi.svg"
        },
        {
            "name": "Cambodia",
            "code": "KH",
            "flag": "https://media.api-sports.io/flags/kh.svg"
        },
        {
            "name": "Cameroon",
            "code": "CM",
            "flag": "https://media.api-sports.io/flags/cm.svg"
        },
        {
            "name": "Canada",
            "code": "CA",
            "flag": "https://media.api-sports.io/flags/ca.svg"
        },
        {
            "name": "Chile",
            "code": "CL",
            "flag": "https://media.api-sports.io/flags/cl.svg"
        },
        {
            "name": "China",
            "code": "CN",
            "flag": "https://media.api-sports.io/flags/cn.svg"
        },
        {
            "name": "Chinese-Taipei",
            "code": "TW",
            "flag": "https://media.api-sports.io/flags/tw.svg"
        },
        {
            "name": "Colombia",
            "code": "CO",
            "flag": "https://media.api-sports.io/flags/co.svg"
        },
        {
            "name": "Congo",
            "code": "CD",
            "flag": "https://media.api-sports.io/flags/cd.svg"
        },
        {
            "name": "Congo-DR",
            "code": "CG",
            "flag": "https://media.api-sports.io/flags/cg.svg"
        },
        {
            "name": "Costa-Rica",
            "code": "CR",
            "flag": "https://media.api-sports.io/flags/cr.svg"
        },
        {
            "name": "Crimea",
            "code": "UA",
            "flag": "https://media.api-sports.io/flags/ua.svg"
        },
        {
            "name": "Croatia",
            "code": "HR",
            "flag": "https://media.api-sports.io/flags/hr.svg"
        },
        {
            "name": "Cuba",
            "code": "CU",
            "flag": "https://media.api-sports.io/flags/cu.svg"
        },
        {
            "name": "Curacao",
            "code": "CW",
            "flag": "https://media.api-sports.io/flags/cw.svg"
        },
        {
            "name": "Cyprus",
            "code": "CY",
            "flag": "https://media.api-sports.io/flags/cy.svg"
        },
        {
            "name": "Czech-Republic",
            "code": "CZ",
            "flag": "https://media.api-sports.io/flags/cz.svg"
        },
        {
            "name": "Denmark",
            "code": "DK",
            "flag": "https://media.api-sports.io/flags/dk.svg"
        },
        {
            "name": "Dominican-Republic",
            "code": "DO",
            "flag": "https://media.api-sports.io/flags/do.svg"
        },
        {
            "name": "Ecuador",
            "code": "EC",
            "flag": "https://media.api-sports.io/flags/ec.svg"
        },
        {
            "name": "Egypt",
            "code": "EG",
            "flag": "https://media.api-sports.io/flags/eg.svg"
        },
        {
            "name": "El-Salvador",
            "code": "SV",
            "flag": "https://media.api-sports.io/flags/sv.svg"
        },
        {
            "name": "England",
            "code": "GB",
            "flag": "https://media.api-sports.io/flags/gb.svg"
        },
        {
            "name": "Estonia",
            "code": "EE",
            "flag": "https://media.api-sports.io/flags/ee.svg"
        },
        {
            "name": "Eswatini",
            "code": "SZ",
            "flag": "https://media.api-sports.io/flags/sz.svg"
        },
        {
            "name": "Ethiopia",
            "code": "ET",
            "flag": "https://media.api-sports.io/flags/et.svg"
        },
        {
            "name": "Faroe-Islands",
            "code": "FO",
            "flag": "https://media.api-sports.io/flags/fo.svg"
        },
        {
            "name": "Fiji",
            "code": "FJ",
            "flag": "https://media.api-sports.io/flags/fj.svg"
        },
        {
            "name": "Finland",
            "code": "FI",
            "flag": "https://media.api-sports.io/flags/fi.svg"
        },
        {
            "name": "France",
            "code": "FR",
            "flag": "https://media.api-sports.io/flags/fr.svg"
        },
        {
            "name": "Gambia",
            "code": "GM",
            "flag": "https://media.api-sports.io/flags/gm.svg"
        },
        {
            "name": "Georgia",
            "code": "GE",
            "flag": "https://media.api-sports.io/flags/ge.svg"
        },
        {
            "name": "Germany",
            "code": "DE",
            "flag": "https://media.api-sports.io/flags/de.svg"
        },
        {
            "name": "Ghana",
            "code": "GH",
            "flag": "https://media.api-sports.io/flags/gh.svg"
        },
        {
            "name": "Gibraltar",
            "code": "GI",
            "flag": "https://media.api-sports.io/flags/gi.svg"
        },
        {
            "name": "Greece",
            "code": "GR",
            "flag": "https://media.api-sports.io/flags/gr.svg"
        },
        {
            "name": "Guadeloupe",
            "code": "GP",
            "flag": "https://media.api-sports.io/flags/gp.svg"
        },
        {
            "name": "Guatemala",
            "code": "GT",
            "flag": "https://media.api-sports.io/flags/gt.svg"
        },
        {
            "name": "Guinea",
            "code": "GN",
            "flag": "https://media.api-sports.io/flags/gn.svg"
        },
        {
            "name": "Haiti",
            "code": "HT",
            "flag": "https://media.api-sports.io/flags/ht.svg"
        },
        {
            "name": "Honduras",
            "code": "HN",
            "flag": "https://media.api-sports.io/flags/hn.svg"
        },
        {
            "name": "Hong-Kong",
            "code": "HK",
            "flag": "https://media.api-sports.io/flags/hk.svg"
        },
        {
            "name": "Hungary",
            "code": "HU",
            "flag": "https://media.api-sports.io/flags/hu.svg"
        },
        {
            "name": "Iceland",
            "code": "IS",
            "flag": "https://media.api-sports.io/flags/is.svg"
        },
        {
            "name": "India",
            "code": "IN",
            "flag": "https://media.api-sports.io/flags/in.svg"
        },
        {
            "name": "Indonesia",
            "code": "ID",
            "flag": "https://media.api-sports.io/flags/id.svg"
        },
        {
            "name": "Iran",
            "code": "IR",
            "flag": "https://media.api-sports.io/flags/ir.svg"
        },
        {
            "name": "Iraq",
            "code": "IQ",
            "flag": "https://media.api-sports.io/flags/iq.svg"
        },
        {
            "name": "Ireland",
            "code": "IE",
            "flag": "https://media.api-sports.io/flags/ie.svg"
        },
        {
            "name": "Israel",
            "code": "IL",
            "flag": "https://media.api-sports.io/flags/il.svg"
        },
        {
            "name": "Italy",
            "code": "IT",
            "flag": "https://media.api-sports.io/flags/it.svg"
        },
        {
            "name": "Ivory-Coast",
            "code": "CI",
            "flag": "https://media.api-sports.io/flags/ci.svg"
        },
        {
            "name": "Jamaica",
            "code": "JM",
            "flag": "https://media.api-sports.io/flags/jm.svg"
        },
        {
            "name": "Japan",
            "code": "JP",
            "flag": "https://media.api-sports.io/flags/jp.svg"
        },
        {
            "name": "Jordan",
            "code": "JO",
            "flag": "https://media.api-sports.io/flags/jo.svg"
        },
        {
            "name": "Kazakhstan",
            "code": "KZ",
            "flag": "https://media.api-sports.io/flags/kz.svg"
        },
        {
            "name": "Kenya",
            "code": "KE",
            "flag": "https://media.api-sports.io/flags/ke.svg"
        },
        {
            "name": "Kosovo",
            "code": "XK",
            "flag": "https://media.api-sports.io/flags/xk.svg"
        },
        {
            "name": "Kuwait",
            "code": "KW",
            "flag": "https://media.api-sports.io/flags/kw.svg"
        },
        {
            "name": "Kyrgyzstan",
            "code": "KG",
            "flag": "https://media.api-sports.io/flags/kg.svg"
        },
        {
            "name": "Laos",
            "code": "LA",
            "flag": "https://media.api-sports.io/flags/la.svg"
        },
        {
            "name": "Latvia",
            "code": "LV",
            "flag": "https://media.api-sports.io/flags/lv.svg"
        },
        {
            "name": "Lebanon",
            "code": "LB",
            "flag": "https://media.api-sports.io/flags/lb.svg"
        },
        {
            "name": "Liberia",
            "code": "LR",
            "flag": "https://media.api-sports.io/flags/lr.svg"
        },
        {
            "name": "Libya",
            "code": "LY",
            "flag": "https://media.api-sports.io/flags/ly.svg"
        },
        {
            "name": "Liechtenstein",
            "code": "LI",
            "flag": "https://media.api-sports.io/flags/li.svg"
        },
        {
            "name": "Lithuania",
            "code": "LT",
            "flag": "https://media.api-sports.io/flags/lt.svg"
        },
        {
            "name": "Luxembourg",
            "code": "LU",
            "flag": "https://media.api-sports.io/flags/lu.svg"
        },
        {
            "name": "Macedonia",
            "code": "MK",
            "flag": "https://media.api-sports.io/flags/mk.svg"
        },
        {
            "name": "Malawi",
            "code": "MW",
            "flag": "https://media.api-sports.io/flags/mw.svg"
        },
        {
            "name": "Malaysia",
            "code": "MY",
            "flag": "https://media.api-sports.io/flags/my.svg"
        },
        {
            "name": "Maldives",
            "code": "MV",
            "flag": "https://media.api-sports.io/flags/mv.svg"
        },
        {
            "name": "Mali",
            "code": "ML",
            "flag": "https://media.api-sports.io/flags/ml.svg"
        },
        {
            "name": "Malta",
            "code": "MT",
            "flag": "https://media.api-sports.io/flags/mt.svg"
        },
        {
            "name": "Mauritania",
            "code": "MR",
            "flag": "https://media.api-sports.io/flags/mr.svg"
        },
        {
            "name": "Mauritius",
            "code": "MU",
            "flag": "https://media.api-sports.io/flags/mu.svg"
        },
        {
            "name": "Mexico",
            "code": "MX",
            "flag": "https://media.api-sports.io/flags/mx.svg"
        },
        {
            "name": "Moldova",
            "code": "MD",
            "flag": "https://media.api-sports.io/flags/md.svg"
        },
        {
            "name": "Mongolia",
            "code": "MN",
            "flag": "https://media.api-sports.io/flags/mn.svg"
        },
        {
            "name": "Montenegro",
            "code": "ME",
            "flag": "https://media.api-sports.io/flags/me.svg"
        },
        {
            "name": "Morocco",
            "code": "MA",
            "flag": "https://media.api-sports.io/flags/ma.svg"
        },
        {
            "name": "Myanmar",
            "code": "MM",
            "flag": "https://media.api-sports.io/flags/mm.svg"
        },
        {
            "name": "Namibia",
            "code": "NA",
            "flag": "https://media.api-sports.io/flags/na.svg"
        },
        {
            "name": "Nepal",
            "code": "NP",
            "flag": "https://media.api-sports.io/flags/np.svg"
        },
        {
            "name": "Netherlands",
            "code": "NL",
            "flag": "https://media.api-sports.io/flags/nl.svg"
        },
        {
            "name": "New-Zealand",
            "code": "NZ",
            "flag": "https://media.api-sports.io/flags/nz.svg"
        },
        {
            "name": "Nicaragua",
            "code": "NI",
            "flag": "https://media.api-sports.io/flags/ni.svg"
        },
        {
            "name": "Nigeria",
            "code": "NG",
            "flag": "https://media.api-sports.io/flags/ng.svg"
        },
        {
            "name": "Northern-Ireland",
            "code": "GB",
            "flag": "https://media.api-sports.io/flags/gb.svg"
        },
        {
            "name": "Norway",
            "code": "NO",
            "flag": "https://media.api-sports.io/flags/no.svg"
        },
        {
            "name": "Oman",
            "code": "OM",
            "flag": "https://media.api-sports.io/flags/om.svg"
        },
        {
            "name": "Pakistan",
            "code": "PK",
            "flag": "https://media.api-sports.io/flags/pk.svg"
        },
        {
            "name": "Palestine",
            "code": "PS",
            "flag": "https://media.api-sports.io/flags/ps.svg"
        },
        {
            "name": "Panama",
            "code": "PA",
            "flag": "https://media.api-sports.io/flags/pa.svg"
        },
        {
            "name": "Paraguay",
            "code": "PY",
            "flag": "https://media.api-sports.io/flags/py.svg"
        },
        {
            "name": "Peru",
            "code": "PE",
            "flag": "https://media.api-sports.io/flags/pe.svg"
        },
        {
            "name": "Philippines",
            "code": "PH",
            "flag": "https://media.api-sports.io/flags/ph.svg"
        },
        {
            "name": "Poland",
            "code": "PL",
            "flag": "https://media.api-sports.io/flags/pl.svg"
        },
        {
            "name": "Portugal",
            "code": "PT",
            "flag": "https://media.api-sports.io/flags/pt.svg"
        },
        {
            "name": "Qatar",
            "code": "QA",
            "flag": "https://media.api-sports.io/flags/qa.svg"
        },
        {
            "name": "Romania",
            "code": "RO",
            "flag": "https://media.api-sports.io/flags/ro.svg"
        },
        {
            "name": "Russia",
            "code": "RU",
            "flag": "https://media.api-sports.io/flags/ru.svg"
        },
        {
            "name": "Rwanda",
            "code": "RW",
            "flag": "https://media.api-sports.io/flags/rw.svg"
        },
        {
            "name": "San-Marino",
            "code": "SM",
            "flag": "https://media.api-sports.io/flags/sm.svg"
        },
        {
            "name": "Saudi-Arabia",
            "code": "SA",
            "flag": "https://media.api-sports.io/flags/sa.svg"
        },
        {
            "name": "Scotland",
            "code": "GB",
            "flag": "https://media.api-sports.io/flags/gb.svg"
        },
        {
            "name": "Senegal",
            "code": "SN",
            "flag": "https://media.api-sports.io/flags/sn.svg"
        },
        {
            "name": "Serbia",
            "code": "RS",
            "flag": "https://media.api-sports.io/flags/rs.svg"
        },
        {
            "name": "Singapore",
            "code": "SG",
            "flag": "https://media.api-sports.io/flags/sg.svg"
        },
        {
            "name": "Slovakia",
            "code": "SK",
            "flag": "https://media.api-sports.io/flags/sk.svg"
        },
        {
            "name": "Slovenia",
            "code": "SI",
            "flag": "https://media.api-sports.io/flags/si.svg"
        },
        {
            "name": "Somalia",
            "code": "SO",
            "flag": "https://media.api-sports.io/flags/so.svg"
        },
        {
            "name": "South-Africa",
            "code": "ZA",
            "flag": "https://media.api-sports.io/flags/za.svg"
        },
        {
            "name": "South-Korea",
            "code": "KR",
            "flag": "https://media.api-sports.io/flags/kr.svg"
        },
        {
            "name": "Spain",
            "code": "ES",
            "flag": "https://media.api-sports.io/flags/es.svg"
        },
        {
            "name": "Sudan",
            "code": "SD",
            "flag": "https://media.api-sports.io/flags/sd.svg"
        },
        {
            "name": "Surinam",
            "code": "SR",
            "flag": "https://media.api-sports.io/flags/sr.svg"
        },
        {
            "name": "Sweden",
            "code": "SE",
            "flag": "https://media.api-sports.io/flags/se.svg"
        },
        {
            "name": "Switzerland",
            "code": "CH",
            "flag": "https://media.api-sports.io/flags/ch.svg"
        },
        {
            "name": "Syria",
            "code": "SY",
            "flag": "https://media.api-sports.io/flags/sy.svg"
        },
        {
            "name": "Tajikistan",
            "code": "TJ",
            "flag": "https://media.api-sports.io/flags/tj.svg"
        },
        {
            "name": "Tanzania",
            "code": "TZ",
            "flag": "https://media.api-sports.io/flags/tz.svg"
        },
        {
            "name": "Thailand",
            "code": "TH",
            "flag": "https://media.api-sports.io/flags/th.svg"
        },
        {
            "name": "Trinidad-And-Tobago",
            "code": "TT",
            "flag": "https://media.api-sports.io/flags/tt.svg"
        },
        {
            "name": "Tunisia",
            "code": "TN",
            "flag": "https://media.api-sports.io/flags/tn.svg"
        },
        {
            "name": "Turkey",
            "code": "TR",
            "flag": "https://media.api-sports.io/flags/tr.svg"
        },
        {
            "name": "Turkmenistan",
            "code": "TM",
            "flag": "https://media.api-sports.io/flags/tm.svg"
        },
        {
            "name": "Uganda",
            "code": "UG",
            "flag": "https://media.api-sports.io/flags/ug.svg"
        },
        {
            "name": "Ukraine",
            "code": "UA",
            "flag": "https://media.api-sports.io/flags/ua.svg"
        },
        {
            "name": "United-Arab-Emirates",
            "code": "AE",
            "flag": "https://media.api-sports.io/flags/ae.svg"
        },
        {
            "name": "Uruguay",
            "code": "UY",
            "flag": "https://media.api-sports.io/flags/uy.svg"
        },
        {
            "name": "USA",
            "code": "US",
            "flag": "https://media.api-sports.io/flags/us.svg"
        },
        {
            "name": "Uzbekistan",
            "code": "UZ",
            "flag": "https://media.api-sports.io/flags/uz.svg"
        },
        {
            "name": "Venezuela",
            "code": "VE",
            "flag": "https://media.api-sports.io/flags/ve.svg"
        },
        {
            "name": "Vietnam",
            "code": "VN",
            "flag": "https://media.api-sports.io/flags/vn.svg"
        },
        {
            "name": "Wales",
            "code": "GB",
            "flag": "https://media.api-sports.io/flags/gb.svg"
        },
        {
            "name": "World",
            "code": null,
            "flag": null
        },
        {
            "name": "Zambia",
            "code": "ZM",
            "flag": "https://media.api-sports.io/flags/zm.svg"
        },
        {
            "name": "Zimbabwe",
            "code": "ZW",
            "flag": "https://media.api-sports.io/flags/zw.svg"
        }
    ]
}
""";

final _leagues = """
{
  "get": "leagues",
  "results": 1,
  "paging": 
  {
    "current": 1,
    "total": 1
  },
 "response": [
    {
      "league": 
      {
        "id": 134,
        "name": "Torneo Federal A",
        "type": "League",
        "logo": "https://media.api-sports.io/football/leagues/134.png"
      },
      "country": {
        "name": "Argentina",
        "code": "AR",
        "flag": "https://media.api-sports.io/flags/ar.svg"
      },
      "seasons": 
      [
        {
          "year": 2022,
          "start": "2022-02-12",
          "end": "2022-10-01",
          "current": true,
          "coverage": {
            "fixtures": {
              "events": true,
              "lineups": true,
              "statistics_fixtures": false,
              "statistics_players": false
            },
            "standings": true,
            "players": true,
            "odds": true,
            "predictions": true
          }
        },
        {
          "year": 2021,
          "start": "2021-02-12",
          "end": "2021-10-01",
          "current": false,
          "coverage": {
            "fixtures": {
              "events": true,
              "lineups": true,
              "statistics_fixtures": false,
              "statistics_players": false
            },
            "standings": true,
            "players": true,
            "odds": true,
            "predictions": true
          }
        },
        {
          "year": 2020,
          "start": "2020-02-12",
          "end": "2020-10-01",
          "current": false,
          "coverage": {
            "fixtures": {
              "events": true,
              "lineups": true,
              "statistics_fixtures": false,
              "statistics_players": false
            },
            "standings": true,
            "players": true,
            "odds": true,
            "predictions": true
          }
        }
      ]
    }      
 ]
}
""";

final _teams = """
{
    "get": "teams",
    "parameters": {
        "league": "130",
        "season": "2022"
    },
    "errors": [],
    "results": 64,
    "paging": {
        "current": 1,
        "total": 1
    },
    "response": [
        {
            "team": {
                "id": 434,
                "name": "Gimnasia L.P.",
                "code": "GIM",
                "country": "Argentina",
                "founded": 1887,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/434.png"
            },
            "venue": {
                "id": 77,
                "name": "Estadio Juan Carmelo Zerillo",
                "address": "Avenida 60 y 118",
                "city": "La Plata, Provincia de Buenos Aires",
                "capacity": 24544,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/77.png"
            }
        },
        {
            "team": {
                "id": 435,
                "name": "River Plate",
                "code": "RIV",
                "country": "Argentina",
                "founded": 1901,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/435.png"
            },
            "venue": {
                "id": 31,
                "name": "Estadio Monumental Antonio Vespucio Liberti",
                "address": "Avenida Presidente José Figueroa Alcorta 7597, Núñez",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 65645,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/31.png"
            }
        },
        {
            "team": {
                "id": 436,
                "name": "Racing Club",
                "code": "RAC",
                "country": "Argentina",
                "founded": 1903,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/436.png"
            },
            "venue": {
                "id": 99,
                "name": "Estadio Presidente Juan Domingo Perón",
                "address": "Calle Mozart y Orestes Omar Corbatta",
                "city": "Avellaneda, Provincia de Buenos Aires",
                "capacity": 51500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/99.png"
            }
        },
        {
            "team": {
                "id": 437,
                "name": "Rosario Central",
                "code": "ROS",
                "country": "Argentina",
                "founded": 1889,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/437.png"
            },
            "venue": {
                "id": 101,
                "name": "Estadio Dr. Lisandro de la Torre",
                "address": "Avenida Génova y Avenida Centenario Rosario Central, Arroyito",
                "city": "Rosario, Provincia de Santa Fe",
                "capacity": 41654,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/101.png"
            }
        },
        {
            "team": {
                "id": 438,
                "name": "Velez Sarsfield",
                "code": "VEL",
                "country": "Argentina",
                "founded": 1910,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/438.png"
            },
            "venue": {
                "id": 115,
                "name": "Estadio José Amalfitani",
                "address": "Avenida Juan B. Justo 9200, Liniers",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 49747,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/115.png"
            }
        },
        {
            "team": {
                "id": 439,
                "name": "Godoy Cruz",
                "code": "GOD",
                "country": "Argentina",
                "founded": 1921,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/439.png"
            },
            "venue": {
                "id": 80,
                "name": "Estadio Malvinas Argentinas",
                "address": "Calle San Francisco De Asis y Boulogne Sur Mer Mendoza",
                "city": "Mendoza, Provincia de Mendoza",
                "capacity": 40268,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/80.png"
            }
        },
        {
            "team": {
                "id": 440,
                "name": "Belgrano Cordoba",
                "code": "BEL",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/440.png"
            },
            "venue": {
                "id": 45,
                "name": "Estadio Julio César Villagra",
                "address": "Calle Dr. Arturo Orgaz 510 y La Rioja, Barrio Alberdi",
                "city": "Ciudad de Córdoba, Provincia de Córdoba",
                "capacity": 28000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/45.png"
            }
        },
        {
            "team": {
                "id": 441,
                "name": "Union Santa Fe",
                "code": "UNI",
                "country": "Argentina",
                "founded": 1907,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/441.png"
            },
            "venue": {
                "id": 1933,
                "name": "Estadio 15 de Abril",
                "address": "Bulevar Pellegrini y Avenida Vicente López y Planes 3513",
                "city": "Ciudad de Santa Fe, Provincia de Santa Fe",
                "capacity": 27000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/1933.png"
            }
        },
        {
            "team": {
                "id": 442,
                "name": "Defensa Y Justicia",
                "code": "DEF",
                "country": "Argentina",
                "founded": 1935,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/442.png"
            },
            "venue": {
                "id": 59,
                "name": "Estadio Norberto Tito Tomaghello",
                "address": "Avenida Humahuaca y Calle 611",
                "city": "Florencio Varela, Provincia de Buenos Aires",
                "capacity": 20000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/59.png"
            }
        },
        {
            "team": {
                "id": 443,
                "name": "Olimpo Bahia Blanca",
                "code": "OLI",
                "country": "Argentina",
                "founded": 1910,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/443.png"
            },
            "venue": {
                "id": 95,
                "name": "Estadio Roberto Natalio Carminatti",
                "address": "Avenida Colón y Calle Angel Brunel",
                "city": "Bahía Blanca, Provincia de Buenos Aires",
                "capacity": 15000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/95.png"
            }
        },
        {
            "team": {
                "id": 444,
                "name": "Patronato",
                "code": "PAT",
                "country": "Argentina",
                "founded": 1914,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/444.png"
            },
            "venue": {
                "id": 96,
                "name": "Estadio Presbítero Bartolomé Grella",
                "address": "Calle Ayacucho y Calle Churruarín",
                "city": "Paraná, Provincia de Entre Ríos",
                "capacity": 22000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/96.png"
            }
        },
        {
            "team": {
                "id": 445,
                "name": "Huracan",
                "code": "HUR",
                "country": "Argentina",
                "founded": 1908,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/445.png"
            },
            "venue": {
                "id": 82,
                "name": "Estadio Tomás Adolfo Ducó",
                "address": "Avenida Amancio Alcorta 2570, Parque Patricios",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 48314,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/82.png"
            }
        },
        {
            "team": {
                "id": 446,
                "name": "Lanus",
                "code": "LAN",
                "country": "Argentina",
                "founded": 1915,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/446.png"
            },
            "venue": {
                "id": 88,
                "name": "Estadio Ciudad de Lanús - Néstor Díaz Pérez",
                "address": "Calle General J. Arias y J. Héctor Guidi",
                "city": "Lanús, Provincia de Buenos Aires",
                "capacity": 46619,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/88.png"
            }
        },
        {
            "team": {
                "id": 448,
                "name": "Colon Santa Fe",
                "code": "COL",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/448.png"
            },
            "venue": {
                "id": 57,
                "name": "Estadio Brigadier General Estanislao López",
                "address": "Calle Juan José Paso y Boulevard Doctor Zavalla",
                "city": "Ciudad de Santa Fe, Provincia de Santa Fe",
                "capacity": 40000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/57.png"
            }
        },
        {
            "team": {
                "id": 449,
                "name": "Banfield",
                "code": "BAN",
                "country": "Argentina",
                "founded": 1896,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/449.png"
            },
            "venue": {
                "id": 43,
                "name": "Estadio Florencio Solá",
                "address": "Calle General Arenales y Peña",
                "city": "Lomas de Zamora, Provincia de Buenos Aires",
                "capacity": 34901,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/43.png"
            }
        },
        {
            "team": {
                "id": 450,
                "name": "Estudiantes L.P.",
                "code": "EST",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/450.png"
            },
            "venue": {
                "id": 12716,
                "name": "Estadio Único Diego Armando Maradona",
                "address": "Avenida 25 y 32",
                "city": "La Plata, Provincia de Buenos Aires",
                "capacity": 53000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/12716.png"
            }
        },
        {
            "team": {
                "id": 451,
                "name": "Boca Juniors",
                "code": "BOC",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/451.png"
            },
            "venue": {
                "id": 46,
                "name": "Estadio Alberto José Armando",
                "address": "Brandsen 805, La Boca",
                "city": "Ciudad de Buenos Aires",
                "capacity": 49000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/46.png"
            }
        },
        {
            "team": {
                "id": 452,
                "name": "Tigre",
                "code": "TIG",
                "country": "Argentina",
                "founded": 1902,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/452.png"
            },
            "venue": {
                "id": 112,
                "name": "Estadio José Dellagiovanna",
                "address": "Avenida Presidente Perón 2650 esq. Guido Spano 1053, Victoria",
                "city": "San Fernando, Provincia de Buenos Aires",
                "capacity": 26282,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/112.png"
            }
        },
        {
            "team": {
                "id": 453,
                "name": "Independiente",
                "code": "IND",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/453.png"
            },
            "venue": {
                "id": 7131,
                "name": "Estadio Libertadores de América",
                "address": "Calle Ricardo Enrique Bochini (ex. Almirante Cordero) 751/83 esq. Alsina",
                "city": "Avellaneda, Provincia de Buenos Aires",
                "capacity": 52364,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/7131.png"
            }
        },
        {
            "team": {
                "id": 455,
                "name": "Atletico Tucuman",
                "code": "TUC",
                "country": "Argentina",
                "founded": 1902,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/455.png"
            },
            "venue": {
                "id": 42,
                "name": "Estadio Monumental Presidente José Fierro",
                "address": "25 de Mayo 1351 y República de Chile, Barrio Norte",
                "city": "San Miguel de Tucumán, Provincia de Tucumán",
                "capacity": 35200,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/42.png"
            }
        },
        {
            "team": {
                "id": 456,
                "name": "Talleres Cordoba",
                "code": "TAL",
                "country": "Argentina",
                "founded": 1913,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/456.png"
            },
            "venue": {
                "id": 110,
                "name": "Estadio Mario Alberto Kempes",
                "address": "Avenida Cárcano, Chateau Carreras",
                "city": "Ciudad de Córdoba, Provincia de Córdoba",
                "capacity": 57503,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/110.png"
            }
        },
        {
            "team": {
                "id": 457,
                "name": "Newells Old Boys",
                "code": "NEW",
                "country": "Argentina",
                "founded": 1903,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/457.png"
            },
            "venue": {
                "id": 93,
                "name": "Estadio Marcelo Alberto Bielsa",
                "address": "Parque de la Independencia, Barrio Centro",
                "city": "Rosario, Provincia de Santa Fe",
                "capacity": 42000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/93.png"
            }
        },
        {
            "team": {
                "id": 458,
                "name": "Argentinos JRS",
                "code": "ARG",
                "country": "Argentina",
                "founded": 1904,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/458.png"
            },
            "venue": {
                "id": 37,
                "name": "Estadio Diego Armando Maradona",
                "address": "Calle Gavilán 2151 y Juan Agustín García, La Paternal",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 24380,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/37.png"
            }
        },
        {
            "team": {
                "id": 459,
                "name": "Arsenal Sarandi",
                "code": "ARS",
                "country": "Argentina",
                "founded": 1957,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/459.png"
            },
            "venue": {
                "id": 38,
                "name": "Estadio Julio Humberto Grondona",
                "address": "Avenida Juan Díaz de Solís 3660, Sarandí",
                "city": "Avellaneda, Provincia de Buenos Aires",
                "capacity": 18300,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/38.png"
            }
        },
        {
            "team": {
                "id": 460,
                "name": "San Lorenzo",
                "code": "LOR",
                "country": "Argentina",
                "founded": 1908,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/460.png"
            },
            "venue": {
                "id": 103,
                "name": "Estadio Pedro Bidegaín",
                "address": "Avenida Perito Moreno y Avenida Varela 1437",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 43494,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/103.png"
            }
        },
        {
            "team": {
                "id": 462,
                "name": "Agropecuario",
                "code": null,
                "country": "Argentina",
                "founded": null,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/462.png"
            },
            "venue": {
                "id": 1770,
                "name": "Estadio Ofelia Rosenzuaig",
                "address": "Calle Carlos Arroyo",
                "city": "Carlos Casares, Provincia de Buenos Aires",
                "capacity": 5000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/1770.png"
            }
        },
        {
            "team": {
                "id": 463,
                "name": "Aldosivi",
                "code": "ALD",
                "country": "Argentina",
                "founded": 1913,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/463.png"
            },
            "venue": {
                "id": 33,
                "name": "Estadio José María Minella",
                "address": "Avenida de las Olimpiadas y Ortíz de Zárate",
                "city": "Mar del Plata, Provincia de Buenos Aires",
                "capacity": 35354,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/33.png"
            }
        },
        {
            "team": {
                "id": 468,
                "name": "Brown DE Adrogue",
                "code": "BRO",
                "country": "Argentina",
                "founded": 1945,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/468.png"
            },
            "venue": {
                "id": 48,
                "name": "Estadio Lorenzo Arandilla",
                "address": "Avenida Bertolomé Cerretti 806 y Presidente Arturo Illia, Adrogué",
                "city": "Almirante Brown, Provincia de Buenos Aires",
                "capacity": 6000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/48.png"
            }
        },
        {
            "team": {
                "id": 469,
                "name": "Deportivo Moron",
                "code": "DEP",
                "country": "Argentina",
                "founded": 1947,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/469.png"
            },
            "venue": {
                "id": 65,
                "name": "Estadio Nuevo Francisco Urbano",
                "address": "Avenida Hipólito Yrigoyen 1600",
                "city": "Morón, Provincia de Buenos Aires",
                "capacity": 32000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/65.png"
            }
        },
        {
            "team": {
                "id": 470,
                "name": "Ferro Carril Oeste",
                "code": "FER",
                "country": "Argentina",
                "founded": 1904,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/470.png"
            },
            "venue": {
                "id": 73,
                "name": "Estadio Arquitecto Ricardo Etcheverry",
                "address": "Avenida Avellaneda 1240, Caballito",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 24442,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/73.png"
            }
        },
        {
            "team": {
                "id": 471,
                "name": "Flandria",
                "code": "FLA",
                "country": "Argentina",
                "founded": 1941,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/471.png"
            },
            "venue": {
                "id": 75,
                "name": "Estadio Carlos V",
                "address": "Avenida San Martín, entre Avenida Fray Manuel de Torres, Jáuregui",
                "city": "Luján, Provincia de Buenos Aires",
                "capacity": 3000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/75.png"
            }
        },
        {
            "team": {
                "id": 473,
                "name": "Independ. Rivadavia",
                "code": "RIV",
                "country": "Argentina",
                "founded": 1913,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/473.png"
            },
            "venue": {
                "id": 83,
                "name": "Estadio Juan Bautista Gargantini",
                "address": "Avenida Boulogne Sur Mer 788, San Martín",
                "city": "Mendoza, Provincia de Mendoza",
                "capacity": 16000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/83.png"
            }
        },
        {
            "team": {
                "id": 474,
                "name": "Sarmiento Junin",
                "code": "SAR",
                "country": "Argentina",
                "founded": 1911,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/474.png"
            },
            "venue": {
                "id": 107,
                "name": "Estadio Eva Perón de Junín",
                "address": "Calle Arias y  Necochea 25",
                "city": "Junín, Provincia de Buenos Aires",
                "capacity": 22000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/107.png"
            }
        },
        {
            "team": {
                "id": 479,
                "name": "Gimnasia Jujuy",
                "code": "GIM",
                "country": "Argentina",
                "founded": 1931,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/479.png"
            },
            "venue": {
                "id": 76,
                "name": "Estadio 23 de Agosto",
                "address": "Avenida El Éxodo y Santa Barbara",
                "city": "San Salvador de Jujuy, Provincia de Jujuy",
                "capacity": 23200,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/76.png"
            }
        },
        {
            "team": {
                "id": 480,
                "name": "Quilmes",
                "code": "QUI",
                "country": "Argentina",
                "founded": 1887,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/480.png"
            },
            "venue": {
                "id": 98,
                "name": "Estadio Centenario Dr. José Luis Meiszner",
                "address": "Avenida Vicente López y Esquiú, Barrio Libertador General San Martín",
                "city": "Quilmes, Provincia de Buenos Aires",
                "capacity": 30200,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/98.png"
            }
        },
        {
            "team": {
                "id": 483,
                "name": "Los Andes",
                "code": "AND",
                "country": "Argentina",
                "founded": 1917,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/483.png"
            },
            "venue": {
                "id": 90,
                "name": "Estadio Eduardo Gallardón",
                "address": "Bouelvard Santa Fé 159",
                "city": "Lomas de Zamora, Provincia de Buenos Aires",
                "capacity": 33532,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/90.png"
            }
        },
        {
            "team": {
                "id": 485,
                "name": "San Martin Tucuman",
                "code": "MAR",
                "country": "Argentina",
                "founded": 1909,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/485.png"
            },
            "venue": {
                "id": 105,
                "name": "Estadio La Ciudadela",
                "address": "Calle Beccer y Avenida Pellegrini",
                "city": "San Miguel de Tucumán, Provincia de Tucumán",
                "capacity": 27000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/105.png"
            }
        },
        {
            "team": {
                "id": 790,
                "name": "Central Cordoba",
                "code": "CEN",
                "country": "Argentina",
                "founded": 1906,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/790.png"
            },
            "venue": {
                "id": 52,
                "name": "Estadio Gabino Sosa",
                "address": "Calle Juan Manuel de Rosas, 1º de Mayo, Gálvez y Virasoro",
                "city": "Rosario, Provincia de Santa Fe",
                "capacity": 17500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/52.png"
            }
        },
        {
            "team": {
                "id": 1064,
                "name": "Platense",
                "code": "PLA",
                "country": "Argentina",
                "founded": 1905,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1064.png"
            },
            "venue": {
                "id": 97,
                "name": "Estadio Ciudad de Vicente López",
                "address": "Calle Juan Zufriategui 2021 (Avenida General Paz), Florida",
                "city": "Vicente López, Provincia de Buenos Aires",
                "capacity": 31030,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/97.png"
            }
        },
        {
            "team": {
                "id": 1065,
                "name": "Central Cordoba de Santiago",
                "code": null,
                "country": "Argentina",
                "founded": 1919,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1065.png"
            },
            "venue": {
                "id": 2997,
                "name": "Estadio Alfredo Terrera",
                "address": "Calle Granadero Saavedra",
                "city": "Santiago del Estero, Provincia de Santiago del Est",
                "capacity": 16000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/2997.png"
            }
        },
        {
            "team": {
                "id": 1066,
                "name": "Gimnasia M.",
                "code": null,
                "country": "Argentina",
                "founded": 1908,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1066.png"
            },
            "venue": {
                "id": 78,
                "name": "Estadio Víctor Antonio Legrotaglie",
                "address": "Calle Lencinas, Parque General San Martín",
                "city": "Mendoza, Provincia de Mendoza",
                "capacity": 11500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/78.png"
            }
        },
        {
            "team": {
                "id": 1924,
                "name": "Deportivo Laferrere",
                "code": "LAF",
                "country": "Argentina",
                "founded": 1956,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1924.png"
            },
            "venue": {
                "id": 87,
                "name": "Estadio Deportivo Laferrere",
                "address": "Calle Osvaldo Magnasco y Rodney",
                "city": "Gregorio de Laferrere, Provincia de Buenos Aires",
                "capacity": 5000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/87.png"
            }
        },
        {
            "team": {
                "id": 1928,
                "name": "Gimnasia Y Tiro",
                "code": "GIM",
                "country": "Argentina",
                "founded": 1902,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1928.png"
            },
            "venue": {
                "id": 79,
                "name": "Estadio El Gigante del Norte",
                "address": "Calle Leguizamón y Vicente López",
                "city": "Salta, Provincia de Salta",
                "capacity": 24300,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/79.png"
            }
        },
        {
            "team": {
                "id": 1929,
                "name": "Deportivo Madryn",
                "code": null,
                "country": "Argentina",
                "founded": 1924,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1929.png"
            },
            "venue": {
                "id": 63,
                "name": "Estadio Abel Sastre",
                "address": "Avenida Juan 23 Norte / Avenida Kenneth Woodley",
                "city": "Puerto Madryn, Provincia de Chubut",
                "capacity": 6000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/63.png"
            }
        },
        {
            "team": {
                "id": 1941,
                "name": "Sol de Mayo",
                "code": null,
                "country": "Argentina",
                "founded": 1920,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1941.png"
            },
            "venue": {
                "id": 1771,
                "name": "Estadio Sol De Mayo",
                "address": "Avenida Francisco de Viedma 1057",
                "city": "Viedma, Provincia de Río Negro",
                "capacity": 5000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/1771.png"
            }
        },
        {
            "team": {
                "id": 1942,
                "name": "Sacachispas",
                "code": "SAC",
                "country": "Argentina",
                "founded": 1948,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1942.png"
            },
            "venue": {
                "id": 102,
                "name": "Estadio Beto Larrosa",
                "address": "Calle Lacarra y José Barros Pazos",
                "city": "Villa Soldati, Provincia de Buenos Aires",
                "capacity": 4000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/102.png"
            }
        },
        {
            "team": {
                "id": 1946,
                "name": "Chaco For Ever",
                "code": "CHA",
                "country": "Argentina",
                "founded": 1913,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1946.png"
            },
            "venue": {
                "id": 55,
                "name": "Estadio Juan Alberto García",
                "address": "Avenida 9 de Julio 2222",
                "city": "Resistencia, Provincia del Chaco",
                "capacity": 30500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/55.png"
            }
        },
        {
            "team": {
                "id": 1949,
                "name": "Cipolletti",
                "code": "CIP",
                "country": "Argentina",
                "founded": 1926,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1949.png"
            },
            "venue": {
                "id": 56,
                "name": "Estadio La Visera de Cemento",
                "address": "Avenida Menguelle 210",
                "city": "Cipolletti, Provincia de Río Negro",
                "capacity": 11000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/56.png"
            }
        },
        {
            "team": {
                "id": 1950,
                "name": "Sportivo Las Parejas",
                "code": null,
                "country": "Argentina",
                "founded": 1922,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1950.png"
            },
            "venue": {
                "id": 109,
                "name": "Estadio La Perrera",
                "address": "Calle 25 entre 22 y 24",
                "city": "Las Parejas, Provincia de Santa Fe",
                "capacity": 3000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/109.png"
            }
        },
        {
            "team": {
                "id": 1951,
                "name": "Central Norte",
                "code": "CEN",
                "country": "Argentina",
                "founded": 1921,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1951.png"
            },
            "venue": {
                "id": 18531,
                "name": "Estadio Dr. Luis Güemes",
                "address": "Avenida Entre Ríos 1495",
                "city": "Salta, Provincia de Salta",
                "capacity": 10000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/18531.png"
            }
        },
        {
            "team": {
                "id": 1957,
                "name": "Racing Cordoba",
                "code": "RAC",
                "country": "Argentina",
                "founded": 1924,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1957.png"
            },
            "venue": {
                "id": 100,
                "name": "Estadio Miguel Sancho",
                "address": "Avenida Jose Quevedo y Calabalumba, Barrio Nueva Itali",
                "city": "Ciudad de Córdoba, Provincia de Córdoba",
                "capacity": 20966,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/100.png"
            }
        },
        {
            "team": {
                "id": 1965,
                "name": "Tristan Suarez",
                "code": "TRI",
                "country": "Argentina",
                "founded": 1929,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/1965.png"
            },
            "venue": {
                "id": 113,
                "name": "Estadio 20 de Octubre",
                "address": "Calle Mariano Moreno y Calle Antonio Fariña, Tristán Suaréz",
                "city": "Ezeiza, Provincia de Buenos Aires",
                "capacity": 13500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/113.png"
            }
        },
        {
            "team": {
                "id": 2425,
                "name": "Acassuso",
                "code": "ACA",
                "country": "Argentina",
                "founded": 1922,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/2425.png"
            },
            "venue": {
                "id": 32,
                "name": "Estadio República de Italia",
                "address": "Autopista Teniente General Pablo Richieri y Avenida Camino de Cintura, Ciudad Evita",
                "city": "La Matanza, Provincia de Buenos Aires",
                "capacity": 6200,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/32.png"
            }
        },
        {
            "team": {
                "id": 2429,
                "name": "Dock Sud",
                "code": "DOC",
                "country": "Argentina",
                "founded": 1916,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/2429.png"
            },
            "venue": {
                "id": 68,
                "name": "Estadio de los Inmigrantes",
                "address": "Avenida Agustin Debenedetti 2005, Dock Sud",
                "city": "Avellaneda, Provincia de Buenos Aires",
                "capacity": 6500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/68.png"
            }
        },
        {
            "team": {
                "id": 2432,
                "name": "Barracas Central",
                "code": "BAR",
                "country": "Argentina",
                "founded": 1904,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/2432.png"
            },
            "venue": {
                "id": 44,
                "name": "Estadio Claudio Fabián Tapia",
                "address": "Avenida Olavaría 3400 y Luna, Bairro Barracas",
                "city": "Capital Federal, Ciudad de Buenos Aires",
                "capacity": 4400,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/44.png"
            }
        },
        {
            "team": {
                "id": 3960,
                "name": "Sportivo Peñarol",
                "code": null,
                "country": "Argentina",
                "founded": null,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/3960.png"
            },
            "venue": {
                "id": 3016,
                "name": "Estadio Ramón Pablo Rojas",
                "address": "Calle San Juan, Barrio Independencia",
                "city": "San Juan, Provincia de San Juan",
                "capacity": 3000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/3016.png"
            }
        },
        {
            "team": {
                "id": 3969,
                "name": "Club Atlético Güemes",
                "code": null,
                "country": "Argentina",
                "founded": null,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/3969.png"
            },
            "venue": {
                "id": 3024,
                "name": "Estadio Arturo Jiya Miranda",
                "address": "Avenida Rivadavia",
                "city": "Santiago del Estero, Prov. de Santiago del Estero",
                "capacity": 2000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/3024.png"
            }
        },
        {
            "team": {
                "id": 8375,
                "name": "Almirante Brown",
                "code": "ALM",
                "country": "Argentina",
                "founded": 1922,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8375.png"
            },
            "venue": {
                "id": 5959,
                "name": "Estadio Fragata Presidente Sarmiento",
                "address": "Calle José Ignacio Rucci y Calle José Mármol, Isidro Casanova",
                "city": "La Matanza, Provincia de Buenos Aires",
                "capacity": 19000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5959.png"
            }
        },
        {
            "team": {
                "id": 8377,
                "name": "Colegiales",
                "code": "COL",
                "country": "Argentina",
                "founded": 1908,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8377.png"
            },
            "venue": {
                "id": 5961,
                "name": "Estadio de Colegiales",
                "address": "Calle Antonio Malaver 4706 y Gervasio de Posadas, Munro",
                "city": "Vicente López, Provincia de Buenos Aires",
                "capacity": 6000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5961.png"
            }
        },
        {
            "team": {
                "id": 8378,
                "name": "JJ Urquiza",
                "code": "URQ",
                "country": "Argentina",
                "founded": 1936,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8378.png"
            },
            "venue": {
                "id": 5962,
                "name": "Estadio Ramón Roque Martín",
                "address": "Calle Miramar 1001 esq. Primera Junta",
                "city": "Loma Hermosa, Provincia de Buenos Aires",
                "capacity": 2500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5962.png"
            }
        },
        {
            "team": {
                "id": 8386,
                "name": "Ituzaingó",
                "code": "ITU",
                "country": "Argentina",
                "founded": 1912,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8386.png"
            },
            "venue": {
                "id": 5969,
                "name": "Estadio de Ituzaingó",
                "address": "Calle General Angel Pacheco y Mariano Acosta",
                "city": "Ituzaingó, Provincia de Buenos Aires",
                "capacity": 3300,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5969.png"
            }
        },
        {
            "team": {
                "id": 8392,
                "name": "Defensores de Cambaceres",
                "code": "DEF",
                "country": "Argentina",
                "founded": 1921,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8392.png"
            },
            "venue": {
                "id": 5974,
                "name": "Estadio 12 de Octubre",
                "address": "Calle Camino Rivadavia y Quintana",
                "city": "Ensenada, Provincia de Buenos Aires",
                "capacity": 8500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5974.png"
            }
        },
        {
            "team": {
                "id": 8395,
                "name": "Liniers",
                "code": "LIN",
                "country": "Argentina",
                "founded": 1931,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8395.png"
            },
            "venue": {
                "id": 5976,
                "name": "Estadio Juan Antonio Arias",
                "address": "Bermejo y José C. Paz, Barrio Justo Villegas, San Justo",
                "city": "La Matanza, Provincia de Buenos Aires",
                "capacity": 3000,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5976.png"
            }
        },
        {
            "team": {
                "id": 8397,
                "name": "Puerto Nuevo",
                "code": null,
                "country": "Argentina",
                "founded": 1939,
                "national": false,
                "logo": "https://media.api-sports.io/football/teams/8397.png"
            },
            "venue": {
                "id": 5977,
                "name": "Estadio Rubén Carlos Vallejos",
                "address": "Calle Viale 159",
                "city": "Campana, Provincia de Buenos Aires",
                "capacity": 500,
                "surface": "grass",
                "image": "https://media.api-sports.io/football/venues/5977.png"
            }
        }
    ]
}
""";

class MockAPIClient implements ApiClient {
  Future<APIResponse> getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic>? parameters,) async {
    var decodedJson;

    switch (endpoint) {
      case Endpoint.countries:
        decodedJson = jsonDecode(_countries);
        break;
      case Endpoint.leagues:
        decodedJson = jsonDecode(_leagues);
        break;
      case Endpoint.teams:
        decodedJson = jsonDecode(_teams);
        break;
      default:
        decodedJson = {};
    }

    return Future.delayed(Duration(seconds: 1), () {
      return APIResponse.fromJson(
        decodedJson,
            (list) => List<T>.from(list.map((object) => endpoint.parser(object))),
      );
    });
  }
}