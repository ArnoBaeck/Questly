# Questly – Your Local Quest Tracker 🗘️📍

**Questly** is een speelse iOS-applicatie waarin gebruikers lokale uitdagingen (challenges) kunnen ontdekken, accepteren en voltooien om beloningen te verdienen. De app maakt gebruik van interactieve kaarten, lokale gebruikersopslag en externe data via een API voor het ophalen van uitdagingen en winkelitems.

> Gebouwd als eindproject binnen het vak iOS Development aan Erasmushogeschool Brussel.

---

## 🧹 Features

* 📍 Interactieve kaart met aangepaste markers
* 💬 Challenge-info verschijnt bij het klikken op een marker
* 🧠 Challenges zijn afkomstig uit een externe API (via PocketHost)
* 👤 Lokale gebruikersprofielen zonder externe login
* 🛍️ Shop met coins als valuta
* 🗞️ Voltooide quests geven direct beloning via lokale opslag
* 🧱 Gebruik van locatie om gebruikerservaring te personaliseren

---

## 📲 Screenshots

> *(Screenshots kunnen hier worden toegevoegd wanneer beschikbaar.)*

---

## ⚙️ Installatie & Gebruik

1. Clone dit project:

   ```bash
   git clone https://github.com/EHB-MCT/Questly.git
   ```
2. Open `Questly.xcodeproj` in Xcode.
3. Run op een simulator of fysiek toestel (iOS 17+ aanbevolen).
4. Zorg dat je toegang tot internet hebt om externe JSON-data op te halen.
5. Vergeet niet: de locatiepermissie is nodig voor volledige functionaliteit.

---

## 📚 Gebruikte technologieën

* SwiftUI
* MapKit
* Combine & State Management met `@State`
* JSONDecoder voor externe data parsing
* UserDefaults voor lokale gebruikersgegevens
* NavigationStack & Viewsysteem in MVC-stijl

---

## 🔗 Bronnen

* [ChatGPT – Markerweergave & DetailView logica](https://chatgpt.com/share/67f4fe50-2944-800e-94bf-1bcee26214c0)
* [ChatGPT – Layout, navigatie & animatiehulp](https://chatgpt.com/share/6835c843-8e50-800e-874c-398c91824703)
* [GitHub Copilot](https://github.com/features/copilot)
* [Apple Developer Documentation](https://developer.apple.com/documentation/)
* [Swift by Sundell](https://www.swiftbysundell.com/)
* [Udemy course — Master iOS Swift App Development In 2025](https://www.udemy.com/course/master-ios-swift-app-development-uikit-swiftui/?couponCode=PMNVD3025)
* Fellow students van de opleiding MCT voor feedback en testinput

---

## 🙋 Contact

**Arno Baeck**
📧 [arno.baeck@student.ehb.be](mailto:arno.baeck@student.ehb.be)
📧 [arno.baeck@live.be](mailto:arno.baeck@live.be)

---

> Bedankt voor het bekijken van Questly! Veel plezier met het ontdekken van je lokale missies!
