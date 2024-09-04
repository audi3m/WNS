//
//  Database.swift
//  WNS
//
//  Created by J Oh on 8/29/24.
//

import Foundation

struct Wine: Codable, Hashable {
    let id: String
    let name: String
    let imageURL: String
    let type: String
    let year: Int
    let winery: String
    let variety: String
    let region: String
    let country: String
    let alcohol: Double
    
    var place: String {
        region + ", " + country
    }
    
    var letter: String {
        switch type {
        case "Red": "R"
        case "White": "W"
        case "Sparkling": "S"
        default:
            ""
        }
    }
    
    var nameForHashtag: String {
        "\(HashtagForWineSearch.prefix)" + name.replacingOccurrences(of: " ", with: "")
    }
    
}

extension Wine {
    func toJsonString() -> String? {
        let encoder = JSONEncoder() 
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding Wine to JSON: \(error)")
            return nil
        }
    }
    
    static func fromJsonString(_ jsonString: String) -> Wine? {
        let decoder = JSONDecoder()
        do {
            let jsonData = Data(jsonString.utf8)
            let wine = try decoder.decode(Wine.self, from: jsonData)
            return wine
        } catch {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

enum WineData {
    static let wineList = """
[
    {
        "id": "1",
        "name": "샤또 마고",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10033-Chateau-Margaux-O-800_0504db8a-6107-495c-a0c6-bdee0419e433_800x800.png?v=1711942484",
        "type": "Red",
        "year": 2015,
        "winery": "Château Margaux",
        "variety": "Cabernet Sauvignon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.5
    },
    {
        "id": "2",
        "name": "샤또 라피트 로칠드",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10786-chateau-lafite-rothschild-h-790_790x790.png?v=1682582717",
        "type": "Red",
        "year": 2016,
        "winery": "Château Lafite Rothschild",
        "variety": "Cabernet Sauvignon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.2
    },
    {
        "id": "3",
        "name": "오퍼스 원",
        "imageURL": "https://www.directwine.shop/cdn/shop/products/151506-flasche_600_600x.png?v=1677220280",
        "type": "Red",
        "year": 2017,
        "winery": "Opus One",
        "variety": "Cabernet Sauvignon",
        "region": "Napa Valley",
        "country": "USA",
        "alcohol": 14.5
    },
    {
        "id": "4",
        "name": "도멘 드 라 로마네 콩티",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10428-domaine-de-la-romanee-conti-romanee-saint-vivant-2015-O2-800_742630f2-a9e5-4b25-992c-d45d74355179_1000x.png?v=1700639545",
        "type": "Red",
        "year": 2018,
        "winery": "Domaine de la Romanée-Conti",
        "variety": "Pinot Noir",
        "region": "Burgundy",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "5",
        "name": "샤또 라투르",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10784-grand-vin-de-chateau-latour-paullac-france-o-800_72fc7a8e-b4fe-4a85-9993-0470e0f075ad_800x.png?v=1700185919",
        "type": "Red",
        "year": 2014,
        "winery": "Château Latour",
        "variety": "Cabernet Sauvignon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.4
    },
    {
        "id": "6",
        "name": "샤또 무통 로칠드",
        "imageURL": "https://awine.kr/wp-content/uploads/vb_wine_img/1492.png",
        "type": "Red",
        "year": 2015,
        "winery": "Château Mouton Rothschild",
        "variety": "Cabernet Sauvignon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.6
    },
    {
        "id": "7",
        "name": "펜폴즈, 빈 389 카베르네 쉬라즈",
        "imageURL": "https://www.directwine.shop/cdn/shop/products/10453-Penfolds-Bin-389-Cabernet-Shiraz-2020_800x800_dc05dca2-b4e9-40a8-aa0d-f688717d09c3_800x.png?v=1678773251",
        "type": "Red",
        "year": 2017,
        "winery": "Penfolds",
        "variety": "Shiraz",
        "region": "South Australia",
        "country": "Australia",
        "alcohol": 14.5
    },
    {
        "id": "8",
        "name": "파고 데 로스 카페자네스, 엘 피콘",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/30046-parcela-el-picon-pago-de-los-capellanes-blanco-h-800_800x.png?v=1711066926",
        "type": "Red",
        "year": 2010,
        "winery": "Vega Sicilia",
        "variety": "Tempranillo",
        "region": "Ribera del Duero",
        "country": "Spain",
        "alcohol": 14.5
    },
    {
        "id": "9",
        "name": "기콘다",
        "imageURL": "https://giaconda.com.au/cms_images/316_30-04-2024_2002.png",
        "type": "White",
        "year": 2015,
        "winery": "Giaconda",
        "variety": "Chardonnay",
        "region": "Victoria",
        "country": "Australia",
        "alcohol": 13.5
    },
    {
        "id": "10",
        "name": "사시카이아",
        "imageURL": "https://dohkqc1a6ll6k.cloudfront.net/eyJidWNrZXQiOiJ3aW5lZ3JhcGgtcHJvZHVjdGlvbiIsImtleSI6IndpbmVzL2JpXzI1MTYzLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJmaXQiOiJjb250YWluIiwid2lkdGgiOjMyMH19fQ==?signature=7ba685fd71acb910882fe70468aea1e9aa61fd368214aebfd326afc1576b0377",
        "type": "Red",
        "year": 2017,
        "winery": "Tenuta San Guido",
        "variety": "Cabernet Sauvignon",
        "region": "Tuscany",
        "country": "Italy",
        "alcohol": 13.0
    },
    {
        "id": "11",
        "name": "루이 자도 뮈르소",
        "imageURL": "https://dohkqc1a6ll6k.cloudfront.net/eyJidWNrZXQiOiJ3aW5lZ3JhcGgtcHJvZHVjdGlvbiIsImtleSI6IndpbmVzL2JpXzkxMzEucG5nIiwiZWRpdHMiOnsicmVzaXplIjp7ImZpdCI6ImNvbnRhaW4iLCJ3aWR0aCI6MzIwfX19?signature=d649ce3c91bad9d532b05ca6f7ffadb19cfcd1f01846ca76e21af543b25b350e",
        "type": "Red",
        "year": 2018,
        "winery": "Louis Jadot",
        "variety": "Chardonnay",
        "region": "Burgundy",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "13",
        "name": "몬테벨로",
        "imageURL": "https://dohkqc1a6ll6k.cloudfront.net/eyJidWNrZXQiOiJ3aW5lZ3JhcGgtcHJvZHVjdGlvbiIsImtleSI6IndpbmVzL2JpXzExNzI1LnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJmaXQiOiJjb250YWluIiwid2lkdGgiOjMyMH19fQ==?signature=8b9437026acf1e7cd5e3aed416ee075d92d8295ad6cb5656b2a17c3c8dcfc676",
        "type": "Red",
        "year": 2017,
        "winery": "Ridge Vineyards",
        "variety": "Cabernet Sauvignon",
        "region": "California",
        "country": "USA",
        "alcohol": 13.8
    },
    {
        "id": "14",
        "name": "샤또 디켐",
        "imageURL": "https://m.wineall.co.kr/web/product/big/202302/c0a3670ca19b90c9a222e7ebef4c2e70.png",
        "type": "White",
        "year": 2009,
        "winery": "Château d'Yquem",
        "variety": "Sémillon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 14.0
    },
    {
        "id": "15",
        "name": "루체",
        "imageURL": "https://m.winenara.com/uploads/product/3084_detail_068.png",
        "type": "Red",
        "year": 2015,
        "winery": "Luce della Vite",
        "variety": "Sangiovese",
        "region": "Tuscany",
        "country": "Italy",
        "alcohol": 13.5
    },
    {
        "id": "16",
        "name": "크리스탈",
        "imageURL": "https://dohkqc1a6ll6k.cloudfront.net/eyJidWNrZXQiOiJ3aW5lZ3JhcGgtcHJvZHVjdGlvbiIsImtleSI6IndpbmVzL2JpXzE4MzE3LnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJmaXQiOiJjb250YWluIiwid2lkdGgiOjMyMH19fQ==?signature=919c31662df151aba41d9adde128c09f875b5eeec0851eeb4d14f6483e58b9fd",
        "type": "White",
        "year": 2012,
        "winery": "Louis Roederer",
        "variety": "Chardonnay",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.0
    },
    {
        "id": "17",
        "name": "도멘 르로이",
        "imageURL": "https://www.directwine.shop/cdn/shop/products/10013-domaine-leroy-vosne-romanee-les-beaux-monts-pinot-noir-2013-O-800_800x800.png?v=1679447194",
        "type": "Red",
        "year": 2017,
        "winery": "Domaine Leroy",
        "variety": "Pinot Noir",
        "region": "Burgundy",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "18",
        "name": "로마네 콩티",
        "imageURL": "https://cdn.veluga.kr/files/supplier/undefined/drinks/40.%E1%84%89%E1%85%B5%E1%86%AB%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8B%E1%85%AA%E1%84%8B%E1%85%B5%E1%86%AB_%E1%84%83%E1%85%A9%E1%84%86%E1%85%A6%E1%86%AB-%E1%84%83%E1%85%B3-%E1%84%85%E1%85%A1-%E1%84%85%E1%85%A9%E1%84%86%E1%85%A1%E1%84%82%E1%85%A6-%E1%84%81%E1%85%A9%E1%86%BC%E1%84%84%E1%85%B5-%E1%84%85%E1%85%A9%E1%84%86%E1%85%A1%E1%84%82%E1%85%A6-%E1%84%8A%E1%85%A2%E1%86%BC-%E1%84%87%E1%85%B5%E1%84%87%E1%85%A1%E1%86%BC-%E1%84%80%E1%85%B3%E1%84%85%E1%85%A1%E1%86%BC-%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B1.png",
        "type": "Red",
        "year": 2015,
        "winery": "Domaine de la Romanée-Conti",
        "variety": "Pinot Noir",
        "region": "Burgundy",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "19",
        "name": "샤또 오브리옹",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10761-chateau-haut-brion-2017-h-800_800x800_4a84f6b4-3111-430d-b9ff-3dff72d504fb.png?v=1682484827",
        "type": "Red",
        "year": 2016,
        "winery": "Château Haut-Brion",
        "variety": "Merlot",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 14.5
    },
    {
        "id": "20",
        "name": "살론",
        "imageURL": "https://www.directwine.shop/cdn/shop/files/10056-CHAMPAGNESALON-bouteille2008-700_700x700_c24b9cde-9259-4824-99ac-37dc11dc348c_700x.png?v=1710300434",
        "type": "Red",
        "year": 2008,
        "winery": "Salon",
        "variety": "Chardonnay",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.5
    },
    {
        "id": "21",
        "name": "라 크레마",
        "imageURL": "https://www.naracellar.com/img_wine/upload/big/3553575307_SoLxVwmD_2dddb37e31e4ff4dc9d5c3cf6afea86c30056b55.jpg",
        "type": "White",
        "year": 2018,
        "winery": "La Crema",
        "variety": "Chardonnay",
        "region": "Sonoma Coast",
        "country": "USA",
        "alcohol": 13.5
    },
    {
        "id": "22",
        "name": "테스타마타",
        "imageURL": "https://cdn.veluga.kr/files/supplier/undefined/drinks/72.%E1%84%8B%E1%85%AA%E1%84%8B%E1%85%B5%E1%84%82%E1%85%A6%E1%86%AF_%E1%84%87%E1%85%B5%E1%84%87%E1%85%B5-%E1%84%80%E1%85%B3%E1%84%85%E1%85%A1%E1%84%8E%E1%85%B3-%E1%84%90%E1%85%A6%E1%84%89%E1%85%B3%E1%84%90%E1%85%A1%E1%84%86%E1%85%A1%E1%84%90%E1%85%A1-%E1%84%87%E1%85%B5%E1%84%8B%E1%85%A1%E1%86%BC%E1%84%8F%E1%85%A9.png",
        "type": "White",
        "year": 2017,
        "winery": "Bibi Graetz",
        "variety": "Sangiovese",
        "region": "Tuscany",
        "country": "Italy",
        "alcohol": 14.0
    },
    {
        "id": "23",
        "name": "알마비바",
        "imageURL": "https://wineall.co.kr/web/product/big/202207/f7b4aebb87896fb113807e2cecf03471.png",
        "type": "Red",
        "year": 2016,
        "winery": "Almaviva",
        "variety": "Cabernet Sauvignon",
        "region": "Puente Alto",
        "country": "Chile",
        "alcohol": 14.5
    },
    {
        "id": "25",
        "name": "마르케스 데 레케나 크리안자",
        "imageURL": "https://wineall.co.kr/web/product/big/202112/6b7e3e0cf0d59bd4d11a4292484c7275.png",
        "type": "Red",
        "year": 2015,
        "winery": "Torre Oria",
        "variety": "Tempranillo",
        "region": "Valencia",
        "country": "Spain",
        "alcohol": 13.5
    },
    {
        "id": "26",
        "name": "샤또 생 미셸",
        "imageURL": "https://www.zzanshop.com/data/item/1696558198/654_600.png",
        "type": "White",
        "year": 2018,
        "winery": "Chateau Ste. Michelle",
        "variety": "Riesling",
        "region": "Washington State",
        "country": "USA",
        "alcohol": 12.0
    },
    {
        "id": "27",
        "name": "까델 보스코 프란치아코르타 퀴베 프레스티지 로제",
        "imageURL": "https://cdn.veluga.kr/files/supplier/undefined/drinks/364.%E1%84%82%E1%85%A1%E1%84%85%E1%85%A1%E1%84%89%E1%85%A6%E1%86%AF%E1%84%85%E1%85%A1_%E1%84%81%E1%85%A1%E1%84%83%E1%85%A6%E1%86%AF-%E1%84%87%E1%85%A9%E1%84%89%E1%85%B3%E1%84%8F%E1%85%A9-%E1%84%91%E1%85%B3%E1%84%85%E1%85%A1%E1%86%AB%E1%84%8E%E1%85%B5%E1%84%8B%E1%85%A1%E1%84%8F%E1%85%A9%E1%84%85%E1%85%B3%E1%84%90%E1%85%A1-%E1%84%8F%E1%85%B1%E1%84%87%E1%85%A6-%E1%84%91%E1%85%B3%E1%84%85%E1%85%A6%E1%84%89%E1%85%B3%E1%84%90%E1%85%B5%E1%84%8C%E1%85%B5-%E1%84%85%E1%85%A9%E1%84%8C%E1%85%A6.png",
        "type": "Sparkling",
        "year": 2017,
        "winery": "Ca' del Bosco",
        "variety": "Chardonnay",
        "region": "Franciacorta",
        "country": "Italy",
        "alcohol": 12.5
    },
    {
        "id": "28",
        "name": "그로스 카보네",
        "imageURL": "https://www.directwine.shop/cdn/shop/products/10624-favia-cabone-napa-valley-2018-h-800_800x.png?v=1680049543",
        "type": "Red",
        "year": 2016,
        "winery": "Groth",
        "variety": "Cabernet Sauvignon",
        "region": "Napa Valley",
        "country": "USA",
        "alcohol": 14.2
    },
    {
        "id": "29",
        "name": "로버트 몬다비",
        "imageURL": "https://www.gangnam.wine/shopimages/vinit777/mobile/0/10924460_represent?1704170820",
        "type": "Red",
        "year": 2018,
        "winery": "Robert Mondavi",
        "variety": "Cabernet Sauvignon",
        "region": "Napa Valley",
        "country": "USA",
        "alcohol": 13.5
    },
    {
        "id": "31",
        "name": "라 콘차",
        "imageURL": "https://conchaytoro.com/content/uploads/2018/07/MCC_CS-min-1.png",
        "type": "Red",
        "year": 2014,
        "winery": "La Concha",
        "variety": "Cabernet Sauvignon",
        "region": "Maipo Valley",
        "country": "Chile",
        "alcohol": 13.5
    },
    {
        "id": "33",
        "name": "비올레타",
        "imageURL": "https://www.pfwinesusa.com/uploads/8/7/0/1/87014278/published/lindaflor-lavioleta-sc.png?1652205004",
        "type": "Red",
        "year": 2019,
        "winery": "Violeta",
        "variety": "Malbec",
        "region": "Mendoza",
        "country": "Argentina",
        "alcohol": 14.0
    },
    {
        "id": "35",
        "name": "도멘 드 바로나크",
        "imageURL": "https://images.vivino.com/thumbs/jc_Iz5tNSe2xEm1oRggm-A_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "Domaine de Baron'arques",
        "variety": "Merlot",
        "region": "Limoux",
        "country": "France",
        "alcohol": 14.5
    },
    {
        "id": "36",
        "name": "발디비에소",
        "imageURL": "https://images.vivino.com/thumbs/0pd0sfmKR0e2vJ6wZXIX3w_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Valdivieso",
        "variety": "Pinot Noir",
        "region": "Casablanca Valley",
        "country": "Chile",
        "alcohol": 13.5
    },
    {
        "id": "37",
        "name": "꼬르디에르",
        "imageURL": "https://images.vivino.com/thumbs/HmzmKnPUQbiXc1jTjTM73A_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Cordiers",
        "variety": "Cabernet Sauvignon, Cabernet Franc, Merlot",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "39",
        "name": "까로",
        "imageURL": "https://images.vivino.com/thumbs/t_fJWLrrRbK1yodWl4Invg_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "Caro",
        "variety": "Cabernet Sauvignon, Malbec",
        "region": "Mendoza",
        "country": "Argentina",
        "alcohol": 14.2
    },
    {
        "id": "40",
        "name": "캔달 잭슨",
        "imageURL": "https://images.vivino.com/thumbs/20ykzlp3ToqV0sgtOzH3-A_pb_x960.png",
        "type": "White",
        "year": 2018,
        "winery": "Kendall-Jackson",
        "variety": "Chardonnay",
        "region": "California",
        "country": "USA",
        "alcohol": 13.5
    },
    {
        "id": "41",
        "name": "카페테라스 리저브",
        "imageURL": "https://images.vivino.com/thumbs/LedQfTrqRNOSfE_5PnOAFg_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Trivento",
        "variety": "Malbec",
        "region": "Mendoza",
        "country": "Argentina",
        "alcohol": 14.0
    },
    {
        "id": "42",
        "name": "샤또 드 뿔리니 몽라쉐",
        "imageURL": "https://images.vivino.com/thumbs/JHpyu48PQbeCPmXVhr3gnA_pb_x960.png",
        "type": "White",
        "year": 2015,
        "winery": "Château de Puligny Montrachet",
        "variety": "Chardonnay",
        "region": "Bourgogne",
        "country": "France",
        "alcohol": 13.5
    },
    {
        "id": "43",
        "name": "몬테스 알파 시라",
        "imageURL": "https://images.vivino.com/thumbs/2PrM3OBLQBWcdKE84nVM5A_375x500.jpg",
        "type": "Red",
        "year": 2016,
        "winery": "Montes",
        "variety": "Syrah",
        "region": "Colchagua Valley",
        "country": "Chile",
        "alcohol": 14.5
    },
    {
        "id": "44",
        "name": "테누타 산 피에트로",
        "imageURL": "https://images.vivino.com/thumbs/nsF5yHq7Qo6E0Q6C-HuSCw_pb_x960.png",
        "type": "Sparkling",
        "year": 2017,
        "winery": "Tenuta San Pietro",
        "variety": "Chardonnay, Cortese",
        "region": "Piemonte",
        "country": "Italy",
        "alcohol": 14.0
    },
    {
        "id": "45",
        "name": "가야 바롤로",
        "imageURL": "https://images.vivino.com/thumbs/_x-ijalRQHaTb7Kv_9AW-w_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "Gaja",
        "variety": "Nebbiolo",
        "region": "Piemonte / Barolo",
        "country": "Italy",
        "alcohol": 14.0
    },
    {
        "id": "46",
        "name": "말벡 드 로스 안데스",
        "imageURL": "https://images.vivino.com/thumbs/xaqIkl7ERfa2eFMbh-SVRw_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Malbec de los Andes",
        "variety": "Malbec",
        "region": "Mendoza",
        "country": "Argentina",
        "alcohol": 14.2
    },
    {
        "id": "47",
        "name": "퀸타 두 노발",
        "imageURL": "https://images.vivino.com/thumbs/mkh6ajAaQV6hcAbbMYZp_w_pb_x960.png",
        "type": "Red",
        "year": 2015,
        "winery": "Quinta do Noval",
        "variety": "Shiraz/Syrah, Touriga Nacional, Touriga Franca, Tinta Roriz",
        "region": "Duriense",
        "country": "Portugal",
        "alcohol": 14.5
    },
    {
        "id": "48",
        "name": "피노 누아 드 랑그독",
        "imageURL": "https://images.vivino.com/thumbs/rAOp6kqESya5gA4cmcoaew_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Trois Galets",
        "variety": "Pinot Noir",
        "region": "Languedoc",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "49",
        "name": "그레이 와키",
        "imageURL": "https://images.vivino.com/thumbs/HGlwrbsxQU29VCfodQHcag_pb_x960.png",
        "type": "White",
        "year": 2018,
        "winery": "Greywacke",
        "variety": "Sauvignon Blanc",
        "region": "Marlborough",
        "country": "New Zealand",
        "alcohol": 13.0
    },
    {
        "id": "50",
        "name": "샤또 린치 바즈",
        "imageURL": "https://images.vivino.com/thumbs/sc-22PXLQNmPBVcnl1cnkQ_pb_x960.png",
        "type": "White",
        "year": 2016,
        "winery": "Château Lynch-Bages",
        "variety": "Cabernet Sauvignon",
        "region": "Bordeaux",
        "country": "France",
        "alcohol": 13.5
    },
    {
        "id": "51",
        "name": "제임슨 리저브",
        "imageURL": "https://images.vivino.com/thumbs/3Ljma3y6TZmTJm8Xu67cnw_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Jamieson Ranch",
        "variety": "Cabernet Sauvignon",
        "region": "Napa Valley",
        "country": "USA",
        "alcohol": 14.2
    },
    {
        "id": "52",
        "name": "루이 라투르 폴리시",
        "imageURL": "https://images.vivino.com/thumbs/OlQRfPzBR0qG0VlCym74FA_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "Louis Latour",
        "variety": "Pinot Noir",
        "region": "Bourgogne",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "53",
        "name": "카테나 자파타",
        "imageURL": "https://images.vivino.com/thumbs/L5BuSPpXRXW2ej3KxsgOxg_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Catena Zapata",
        "variety": "Malbec",
        "region": "Mendoza",
        "country": "Argentina",
        "alcohol": 14.0
    },
    {
        "id": "54",
        "name": "볼리나 그란 리제르바",
        "imageURL": "https://images.vivino.com/thumbs/bzTen-gFToaQK7CXYO0llQ_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "San Pedro",
        "variety": "Cabernet Sauvignon",
        "region": "Cachapoal Valley",
        "country": "Chile",
        "alcohol": 14.5
    },
    {
        "id": "55",
        "name": "도멘 라파제",
        "imageURL": "https://images.vivino.com/thumbs/k3FEAgoCS8GTlOA36BGNlQ_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Domaine Lafage",
        "variety": "Shiraz/Syrah",
        "region": "Côtes Catalanes",
        "country": "France",
        "alcohol": 14.0
    },
    {
        "id": "56",
        "name": "쓰리 피어스 피노 그리지오",
        "imageURL": "https://images.vivino.com/thumbs/uUYwG2McRJi8dxOzmkS4Qw_pb_x960.png",
        "type": "White",
        "year": 2018,
        "winery": "Mason Cellars",
        "variety": "Pinot Gris",
        "region": "California",
        "country": "USA",
        "alcohol": 14.5
    },
    {
        "id": "58",
        "name": "샤또 생 미셸 리슬링",
        "imageURL": "https://images.vivino.com/thumbs/PlkMzRPcROOORQ8DxSvCUg_pb_x960.png",
        "type": "White",
        "year": 2018,
        "winery": "Chateau Ste. Michelle",
        "variety": "Riesling",
        "region": "Columbia Valley",
        "country": "USA",
        "alcohol": 12.0
    },
    {
        "id": "59",
        "name": "나파 벨리 진판델",
        "imageURL": "https://images.vivino.com/thumbs/HvooITLjRHuzhzzI6XqnGg_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Brown Estate",
        "variety": "Zinfandel",
        "region": "Napa Valley",
        "country": "USA",
        "alcohol": 14.8
    },
    {
        "id": "60",
        "name": "몬테 풀치아노 다브루쪼",
        "imageURL": "https://images.vivino.com/thumbs/L-ZnNZvdSteAFpt1v0EpGg_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Montepulciano d'Abruzzo",
        "variety": "Montepulciano",
        "region": "Abruzzo",
        "country": "Italy",
        "alcohol": 13.5
    },
    {
        "id": "61",
        "name": "도멘 드라 스시",
        "imageURL": "https://images.vivino.com/thumbs/xe2Qc6LJRpKR5Dtoq4Qgdw_pb_x960.png",
        "type": "Red",
        "year": 2016,
        "winery": "Gigondas La Cave",
        "variety": "Mourvedre, Shiraz/Syrah, Grenache",
        "region": "Rhone Valley",
        "country": "France",
        "alcohol": 13.5
    },
    {
        "id": "62",
        "name": "콘트라다 토스카나 로쏘",
        "imageURL": "https://images.vivino.com/thumbs/UPkNWiPfS4WpNUmcMOKYNA_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "San Felice",
        "variety": "Merlot, Sangiovese, Cabernet Sauvignon",
        "region": "Toscana",
        "country": "Italy",
        "alcohol": 13.5
    },
    {
        "id": "63",
        "name": "킬리켄 리지",
        "imageURL": "https://images.vivino.com/thumbs/JlxSkuJgT6m3Li-XdwHa1Q_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Kilikanoon",
        "variety": "Shiraz",
        "region": "Clare Valley",
        "country": "Australia",
        "alcohol": 14.5
    },
    {
        "id": "69",
        "name": "샤또 탈보",
        "imageURL": "https://images.vivino.com/thumbs/9zhiQv6cR-SfUufc9_CK6w_pb_x960.png",
        "type": "Red",
        "year": 2015,
        "winery": "Château Talbot",
        "variety": "Cabernet Sauvignon, Merlot, Petit Verdot",
        "region": "Saint-Julien",
        "country": "France",
        "alcohol": 13.5
    },
    {
        "id": "70",
        "name": "Parmelee-Hill Stonewall Block Zinfandel",
        "imageURL": "https://images.vivino.com/thumbs/GqjByv7QSwSJho4RJOFHCQ_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Saxon Brown",
        "variety": "Zinfandel",
        "region": "Sonoma Valley",
        "country": "USA",
        "alcohol": 15.0
    },
    {
        "id": "71",
        "name": "올드 바인",
        "imageURL": "https://images.vivino.com/thumbs/u_WjtzVuQUeBb5hi43N6zw_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Old Vine",
        "variety": "Zinfandel",
        "region": "Lodi",
        "country": "USA",
        "alcohol": 14.5
    },
    {
        "id": "72",
        "name": "카사스 델 보스케",
        "imageURL": "https://images.vivino.com/thumbs/5tcmKLP-TlOc0U3H9fftPw_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Casas del Bosque",
        "variety": "Sauvignon Blanc",
        "region": "Casablanca Valley",
        "country": "Chile",
        "alcohol": 13.0
    },
    {
        "id": "76",
        "name": "몬테 벨로",
        "imageURL": "https://images.vivino.com/thumbs/ONrJS4eOS2WFYqMRvAAzsA_pb_x960.png",
        "type": "Red",
        "year": 2015,
        "winery": "I. Brand & Family",
        "variety": "Cabernet Sauvignon",
        "region": "Santa Cruz Mountains",
        "country": "USA",
        "alcohol": 14.0
    },
    {
        "id": "79",
        "name": "아멜리아 샤르도네",
        "imageURL": "https://images.vivino.com/thumbs/aMGk93WAQFqrp4pdeoPhbg_pb_x960.png",
        "type": "White",
        "year": 2018,
        "winery": "Concha y Toro",
        "variety": "Chardonnay",
        "region": "Casablanca Valley",
        "country": "Chile",
        "alcohol": 13.5
    },
    {
        "id": "81",
        "name": "발디비에소 멀로",
        "imageURL": "https://images.vivino.com/thumbs/xcI7GitLTe-bD77cgPEjjQ_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Valdivieso",
        "variety": "Merlot",
        "region": "Central Valley",
        "country": "Chile",
        "alcohol": 14.0
    },
    {
        "id": "86",
        "name": "클라우드 베이 테코코",
        "imageURL": "https://images.vivino.com/thumbs/7tw9lGAySeG1eG2xCnNXUQ_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Cloudy Bay Te Koko",
        "variety": "Sauvignon Blanc",
        "region": "Marlborough",
        "country": "New Zealand",
        "alcohol": 13.5
    },
    {
        "id": "87",
        "name": "드로린 폴리우스",
        "imageURL": "https://images.vivino.com/thumbs/iz_eDz2YS62tPp4fGPQedg_pb_x960.png",
        "type": "White",
        "year": 2016,
        "winery": "Joseph Drouhin",
        "variety": "Chardonnay",
        "region": "Bourgogne",
        "country": "France",
        "alcohol": 13.0
    },
    {
        "id": "88",
        "name": "Tenuta San Guido Guidalberto",
        "imageURL": "https://images.vivino.com/thumbs/jcRAMq8oSRiFUJVq9wE-GQ_pb_x960.png",
        "type": "Red",
        "year": 2017,
        "winery": "Tenuta San Guido",
        "variety": "Merlot",
        "region": "Toscana",
        "country": "Italy",
        "alcohol": 14.5
    },
    {
        "id": "91",
        "name": "리머힐 샤도네이",
        "imageURL": "https://images.vivino.com/thumbs/kPlNoII5TTadernV35oo3Q_375x500.jpg",
        "type": "White",
        "year": 2017,
        "winery": "Lime Hill",
        "variety": "Chardonnay",
        "region": "Wairarapa",
        "country": "New Zealand",
        "alcohol": 13.5
    },
    {
        "id": "93",
        "name": "비냐 콘차 와인메이커스",
        "imageURL": "https://images.vivino.com/thumbs/xI-IFF5QQ5mBOVvIx7a7Ig_pb_x960.png",
        "type": "Red",
        "year": 2018,
        "winery": "Concha y Toro",
        "variety": "Cabernet Sauvignon, Carménère",
        "region": "Central Valley",
        "country": "Chile",
        "alcohol": 14.5
    },
    {
        "id": "96",
        "name": "루이 로드레르 크리스탈",
        "imageURL": "https://images.vivino.com/thumbs/bXZK_MhMQi-a2xrjEITv2A_pb_x960.png",
        "type": "Sparkling",
        "year": 2013,
        "winery": "Louis Roederer Cristal",
        "variety": "Pinot Noir, Chardonnay",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.0
    },
    {
        "id": "97",
        "name": "퀴베 프레스티지 브뤼 샴페인",
        "imageURL": "https://images.vivino.com/thumbs/nK7FiZzfT9i46JC2WHN-oQ_pb_x960.png",
        "type": "Sparkling",
        "year": 2014,
        "winery": "Taittinger",
        "variety": "Chardonnay",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.0
    },
    {
        "id": "101",
        "name": "루이 로드레르 브뤼",
        "imageURL": "https://images.vivino.com/thumbs/DlLFmnx3TXm5sOConh-5KA_pb_x960.png",
        "type": "Sparkling",
        "year": 2016,
        "winery": "Louis Roederer",
        "variety": "Chardonnay, Pinot Noir, Pinot Meunier",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.0
    },
    {
        "id": "102",
        "name": "모엣 샹동 임페리얼",
        "imageURL": "https://images.vivino.com/thumbs/LP_B9yqMQHSuMyd4SLgUSw_pb_x960.png",
        "type": "Sparkling",
        "year": 2018,
        "winery": "Moët & Chandon",
        "variety": "Pinot Noir",
        "region": "Champagne",
        "country": "France",
        "alcohol": 12.0
    }
]
"""
    
}

