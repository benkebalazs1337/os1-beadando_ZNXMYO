#Operációs rendszerek I. - Beadandó

A beadandó feladatom egy bash scriptöl és 3 'response.json'-böl áll.
Egy API segítségével lekérdezek véletlen szerü kérdéseket 3 szempont szerint. A szempontok szerint  a felhasználó választhatja ki hogy milyen kérdések legyenek feltéve.
A válaszokat külön .txt-ben tárolom el, majd amikor a választott szempontok szerint ki akarja valaki íratni a kérdéseket, a lekérdezés linkjéhez hozzáfüzi a script a txt file-okat, és ez alapján a response.json-ba letölti.
A response.json-t még 2x formázom, minden formázás során új .json file-ba íratom ki a szöveget.
A végsö response3.json tárol sok adatot a kérdésekröl. Ezek még nem teljesen megformázott állapotban vannak.
Ha a kérdéseket szeretnénk kiírni, akkor a script kiolvassa a kérdések sorát a fileból és minimálisan formázza azt.
Válaszokat is kiírhatjuk. Ekkor ugyanabból a fileból olvas a script, csak más sorokat is kiírat megformázva.
Ezenkívül még van lehetöség egy alapvetö állapotba visszaállítani a txt fileokat, ezzel a szürök visszaálnak.
Van egy help funkciója is a scriptnek, ami leírja hogy mit csinál.
