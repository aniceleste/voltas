import 'package:flutter/material.dart';

/// Configuraciones de accesibilidad para la aplicación
class AccessibilityConfig {
  // Colores de alto contraste para accesibilidad
  static const Color primaryAccessibleColor = Color(0xFF1565C0); // Azul oscuro
  static const Color secondaryAccessibleColor = Color(0xFF1976D2); // Azul medio
  static const Color successAccessibleColor = Color(0xFF2E7D32); // Verde oscuro
  static const Color warningAccessibleColor = Color(
    0xFFF57C00,
  ); // Naranja oscuro
  static const Color errorAccessibleColor = Color(0xFFD32F2F); // Rojo oscuro
  static const Color textPrimaryColor = Color(0xFF212121); // Negro suave
  static const Color textSecondaryColor = Color(0xFF424242); // Gris oscuro
  static const Color backgroundColor = Color(0xFFFFFFFF); // Blanco
  static const Color surfaceColor = Color(0xFFF5F5F5); // Gris muy claro

  // Tamaños de fuente accesibles (mínimo 16px para legibilidad)
  static const double fontSizeSmall = 16.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeExtraLarge = 24.0;
  static const double fontSizeHeadline = 36.0;
  static const double fontSizeDisplay = 48.0;

  // Espaciado de letras para mejor legibilidad
  static const double letterSpacingTight = 0.1;
  static const double letterSpacingNormal = 0.2;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;

  // Tamaños mínimos de botones para facilitar el toque (mínimo 44px)
  static const Size minimumButtonSize = Size(120.0, 56.0);
  static const Size minimumTouchTarget = Size(44.0, 44.0);

  // Padding y márgenes para mejor espaciado
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 12.0,
  );
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  // Bordes redondeados para mejor apariencia
  static const double borderRadiusSmall = 6.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;

  /// Obtiene un estilo de texto accesible
  static TextStyle getAccessibleTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    String? fontFamily,
  }) {
    return TextStyle(
      fontSize: fontSize ?? fontSizeMedium,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? textPrimaryColor,
      letterSpacing: letterSpacing ?? letterSpacingNormal,
      fontFamily: fontFamily,
    );
  }

  /// Obtiene un estilo de botón accesible
  static ButtonStyle getAccessibleButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    double? fontSize,
    EdgeInsets? padding,
    Size? minimumSize,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primaryAccessibleColor,
      foregroundColor: foregroundColor ?? Colors.white,
      textStyle: TextStyle(
        fontSize: fontSize ?? fontSizeMedium,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacingWide,
      ),
      padding: padding ?? buttonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      minimumSize: minimumSize ?? minimumButtonSize,
    );
  }

  /// Obtiene un contenedor accesible con sombra y borde
  static BoxDecoration getAccessibleContainerDecoration({
    Color? color,
    Color? borderColor,
    double? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius ?? borderRadiusMedium),
      border: Border.all(
        color: borderColor ?? primaryAccessibleColor.withValues(alpha: 0.3),
        width: 1.0,
      ),
      boxShadow:
          boxShadow ??
          [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
    );
  }

  /// Crea un widget Semantics con configuración estándar
  static Widget createAccessibleWidget({
    required String label,
    required Widget child,
    bool? button,
    bool? enabled,
    String? hint,
  }) {
    return Semantics(
      label: label,
      button: button,
      enabled: enabled,
      hint: hint,
      child: child,
    );
  }

  /// Obtiene un tema accesible completo
  static ThemeData getAccessibleTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryAccessibleColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,

      textTheme: TextTheme(
        headlineLarge: getAccessibleTextStyle(
          fontSize: fontSizeDisplay,
          fontWeight: FontWeight.bold,
          letterSpacing: letterSpacingExtraWide,
        ),
        headlineMedium: getAccessibleTextStyle(
          fontSize: fontSizeHeadline,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacingExtraWide,
        ),
        titleLarge: getAccessibleTextStyle(
          fontSize: fontSizeExtraLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacingWide,
        ),
        titleMedium: getAccessibleTextStyle(
          fontSize: fontSizeLarge,
          fontWeight: FontWeight.w500,
          letterSpacing: letterSpacingWide,
        ),
        bodyLarge: getAccessibleTextStyle(
          fontSize: fontSizeMedium,
          letterSpacing: letterSpacingNormal,
        ),
        bodyMedium: getAccessibleTextStyle(
          fontSize: fontSizeSmall,
          letterSpacing: letterSpacingNormal,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: getAccessibleButtonStyle(),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: primaryAccessibleColor,
        foregroundColor: Colors.white,
        titleTextStyle: getAccessibleTextStyle(
          fontSize: fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: letterSpacingWide,
        ),
        elevation: 4.0,
      ),

      listTileTheme: ListTileThemeData(
        titleTextStyle: getAccessibleTextStyle(
          fontSize: fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: letterSpacingNormal,
        ),
        subtitleTextStyle: getAccessibleTextStyle(
          fontSize: fontSizeSmall,
          color: textSecondaryColor,
          letterSpacing: letterSpacingNormal,
        ),
        contentPadding: listItemPadding,
      ),
    );
  }
}
