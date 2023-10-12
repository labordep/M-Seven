[![License](https://img.shields.io/github/license/labordep/M-Seven.svg)](./LICENSE)

<badges for only one tests script>
   
[![Tests](https://github.com/labordep/M-Seven/actions/workflows/Tests.yml/badge.svg)](https://github.com/labordep/M-Seven/actions/workflows/Tests.yml)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)

# M-Seven

This project is inspired by : 
- https://www.coranac.com/tonc/text/mode7.htm
- https://github.com/StanislavPetrovV/Mode7

## Getting Started

### Installation

To install the project on your Pharo image you can just execute the following script:

```smalltalk
Metacello new
   baseline: 'MSeven';
   repository: 'github://labordep/M-Seven:main/src';
   load.
```

## Dependencies

No dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
