# ATIS and weather

ATC's weather is the weather in your X-Plane.

## The ATIS

Tune an airport's ATIS frequency on COM1 or COM2 and the recording loops, starting mid-broadcast like the real thing. Tune away and it stops. ATC's calls and your own transmissions come first; the loop picks up again after them.

It gives the information letter, the time, the wind, visibility, the sky, temperature, the altimeter, and the runways and approach in use.

- **The letter** starts at a random one and advances when the weather changes.
- **The sky** comes from X-Plane's cloud layers: "few", "scattered", "broken" or "overcast" with the height, and the ceiling named ("ceiling niner hundred overcast").
- **Gusts** are reported when the gust is 10 knots or more over the steady wind.
- **Wind shear** in your X-Plane weather becomes "wind shear reported", in the ATIS and in Tower's takeoff and landing clearances.

The window names the ATIS on the radio tuned to it ("KSEA ATIS Charlie · looping"), tags each ATIS in the Frequencies card with its current letter, and puts the full text in the log while you listen.

## The letter on the radio

Say the letter on your first call: "with information Charlie". ATC remembers it for that airport. When the letter has changed since, ATC asks: "confirm you have information Kilo, altimeter three zero zero two". Arriving, Approach checks the destination's letter.

## Weather in clearances

- Ground gives the wind and the altimeter with your taxi if you did not report the ATIS.
- Tower gives the wind with every takeoff and landing clearance.
- Radar controllers give the altimeter when you check in and when you start down.
- The runway in use follows the wind. A wind shift can change the runway while you taxi, and Ground then gives you a new route.

## Where the weather comes from

The client sends the weather at your aircraft about every five seconds: wind, pressure, temperature, visibility, gusts, wind shear and cloud layers. For an airport you are not at yet, ATC uses X-Plane's regional weather as its estimate. Nothing is fetched from the real world, so ATC always agrees with what you see out of the window.
