#  Orrery

A Swift library for calculating Sun, Moon and Earth positions, phases and other astrolonomical metrics and events.

## Warning

This library is for research and recreational use only. 

Due to atmospheric conditions, astronomical phenomena, the imperfections and inherent limitations to utilitized algorithms and our incomplete and evolving understanding of the known universe, calculated results may vary significantly from actual observed values.

## Mahalo Nui Loa

Infinite gratitude to these libraries and countless other resources:

- [Astronomy Answers](http://aa.quae.nl/en/reken/zonpositie.html)
- [Suncalc](https://github.com/mourner/suncalc)
- [Sundial](https://github.com/Kalyse/Sundial)
- [Earth System Research Laboratory](https://www.esrl.noaa.gov)

## Usage Examples

```swift
// Configure orrery for specific time and location
let orrery = Orrery(NSDate(), latitude: 21.18, longitude: -157.51);
```
