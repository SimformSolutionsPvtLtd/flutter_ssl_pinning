# Flutter SSL Pinning Example

* This project demonstrates how to implement SSL pinning in a Flutter application using the dio package to secure network requests. SSL pinning ensures that communication is only established with a trusted server, protecting against man-in-the-middle (MITM) attacks.

### What is SSL Pinning?
* SSL pinning is a security technique used in mobile (or client) applications to associate a server's SSL/TLS certificate or public key directly with the app. This prevents attackers from intercepting or manipulating data by impersonating the server, even if they manage to obtain a valid certificate for the server.

* By using SSL pinning, your app ensures that it only communicates with the specific server it trusts, making it more resistant to attacks that rely on compromised networks or certificates.

### Key Features

* SSL pinning implemented using the dio package

* Enhances security by validating server certificates before making network requests

* Protects against man-in-the-middle attacks and compromised certificate authorities (CAs)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter-ssl-pinning-example.git
```

2. Navigate to the project directory:
```bash
cd flutter-ssl-pinning-example
```

3. Install dependencies:
```bash
flutter pub get
```

### Example

1. Add the SSL Certificate to Assets
   * Place your server’s SSL certificate file inside the assets folder of your project.
2. Configure the Security Context
   * Use a `SecurityContext` to manage and configure TLS/SSL settings for your app. 
   * Load the certificate from assets and set it as a trusted certificate in the `SecurityContext`. 
   * This effectively pins the server’s certificate and ensures that only this trusted certificate is accepted for SSL connections.
3. Use the Custom Security Context in Dio
   * Attach the configured SecurityContext to a custom HttpClient. 
   * Override the badCertificateCallback to reject all untrusted certificates.