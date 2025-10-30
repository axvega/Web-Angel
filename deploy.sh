#!/bin/bash

# Script de despliegue simple y funcional para Hugo
# Autor: Ángel de la Vega

# Configuración
web_dir="/home/axvega/git/Web-Angel"
public_dir="/home/axvega/git/Web-public"

echo "======================================"
echo "   DESPLIEGUE RÁPIDO HUGO"
echo "======================================"

# Paso 1: Verificar directorio
if [ ! -f "hugo.toml" ]; then
    echo "ERROR: Debes ejecutar desde Web-Angel"
    echo "Usa: cd ~/git/Web-Angel && ./deploy.sh"
    exit 1
fi

# Paso 2: Guardar cambios en desarrollo
echo "1. Guardando cambios desarrollo..."
git add .
read -p "   Mensaje commit: " mensaje
git commit -m "$mensaje"
git push
echo "   ✓ Desarrollo subido"

# Paso 3: Generar sitio
echo ""
echo "2. Generando sitio Hugo..."
hugo --minify
echo "   ✓ Sitio generado"

# Paso 4: Copiar a producción
echo ""
echo "3. Copiando a producción..."
# Limpiar directorio de destino y copiar nuevo contenido
rm -rf "$public_dir"/*
cp -r public/* "$public_dir"/
echo "   ✓ Archivos copiados"

# Paso 5: Subir a GitHub Pages
echo ""
echo "4. Subiendo a GitHub..."
cd "$public_dir"
git add .
git commit -m "Deploy: $(date +"%d/%m/%Y %H:%M")"
git push origin main
echo "   ✓ GitHub actualizado"

echo ""
echo "======================================"
echo "   ¡SITIO ACTUALIZADO!"
echo "======================================"
echo "Netlify debería detectar los cambios automáticamente"
echo "URL: https://web-angel1.netlify.app/"
