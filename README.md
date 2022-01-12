# Warning ⚠️
Gemaker evolucionó mucho al caso particular de Fintual y tomamos la decisión de mantener una versión interna únicamente.
Este proyecto está disponible como read-only para fines históricos.

Para una versión mantenida puedes revisar https://github.com/platanus/gemaker.

# Gemaker

Es una gema de Ruby que permite generar gemas/engines dentro de un proyecto Rails con el fin de modularizar tu aplicación.

## Instalación

Agrega en el `Gemfile` de tu proyecto:

```ruby
gem 'fintual-gemaker', github: 'fintual/gemaker', branch: 'main'
```

y luego:

```
$ bundle install
```

## Uso

En el root de tu proyecto Rails, ejecuta:

```
$ bundle exec gemaker new [gem|engine]_name
```

Ejemplo:

```
$ bundle exec gemaker new bank_api
```

El código anterior creará la estructura de archivos para nueva tu gema (o engine) de nombre `BankApi`.

Ten en cuenta que luego de crear la gema, necesitarás agregarla a mano en el `Gemfile` de tu proyecto así:

```ruby
gem "bank_api", path: "gems/bank_api"
```

## Contribuir

Reportes de bugs y PRs en https://github.com/fintual/gemaker.


## Licencia

[MIT License](https://opensource.org/licenses/MIT)
