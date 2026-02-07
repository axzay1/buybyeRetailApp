# Assets Directory

This directory contains all static assets used in the BuyBye app.

## Structure

```
assets/
├── images/          # General images
├── icons/           # App icons and custom icons
└── logo/            # BuyBye logo files
```

## Logo Files

Add your BuyBye logo in the following formats:

- `logo/buybye_logo.png` - Primary logo (for light backgrounds)
- `logo/buybye_logo_white.png` - White logo (for dark backgrounds)
- `logo/buybye_icon.png` - App icon (512x512px)

## Icons

Place custom icons here:

- `icons/bcoin.png` - B-coin icon
- `icons/cart.png` - Shopping cart icon
- `icons/sell.png` - Sell icon
- `icons/wallet.png` - Wallet icon

## Images

General app images:

- `images/placeholder_product.png` - Product placeholder
- `images/placeholder_user.png` - User avatar placeholder
- `images/empty_cart.png` - Empty cart illustration
- `images/empty_orders.png` - Empty orders illustration
- `images/empty_wallet.png` - Empty wallet illustration

## Image Guidelines

### Formats
- Use PNG for images with transparency
- Use JPEG for photos
- Use SVG when possible (requires flutter_svg)

### Sizes
- Logo: 256x256px or higher
- Icons: 48x48px to 128x128px
- Product images: 800x800px recommended
- Banner images: 1200x400px recommended

### Optimization
- Compress images before adding
- Use tools like TinyPNG or ImageOptim
- Keep file sizes small for better performance

## Using Assets

Update `pubspec.yaml` if you add new asset directories:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/logo/
```

Reference assets in code:

```dart
// From constants
import 'package:buybye_retail_app/core/constants/app_assets.dart';

Image.asset(AppAssets.logo)

// Or directly
Image.asset('assets/logo/buybye_logo.png')
```

## Notes

- All assets should be added to version control
- Provide assets in multiple resolutions if needed (@2x, @3x)
- Follow naming convention: lowercase with underscores
- Avoid special characters in filenames
