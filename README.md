# LNSEurekaExtras

A series of additions to the [Eureka](https://github.com/xmartlabs/Eureka#installation) package that make using it ever so slightly simpler (Eureka does not need much help).

## Swift Package Manager

After you set up your Package.swift manifest file, you can add Eureka as a dependency by adding it to the dependencies value of your Package.swift.

```
dependencies: [ 
    .package(url: "https://github.com/xmartlabs/Eureka.git", from: "5.3.2"),
    .package(url: "https://github.com/alldritt/LNSEurekaExtras.git", branch: "main")
]
```
