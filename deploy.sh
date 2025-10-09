#!/bin/bash

# Script de despliegue simple para Hugo
# Autor: Ángel de la Vega

echo "======================================"
echo "   DESPLIEGUE AUTOMÁTICO"
echo "======================================"

# Paso 1: Guardar cambios en desarrollo
echo "Paso 1: Guardando cambios en desarrollo..."
git add .
read -p "Mensaje del commit: " mensaje
git commit -m "$mensaje" 2>/dev/null || echo "No hay cambios nuevos"
echo "✓ Listo"

# Paso 2: Generar sitio con Hugo
echo ""
echo "Paso 2: Generando sitio con Hugo..."
hugo --minify
echo "✓ Sitio generado"

# Paso 3: Copiar a repositorio de producción
echo ""
echo "Paso 3: Copiando a repositorio de producción..."
cp -r public/* ~/git/Web-public/
echo "✓ Archivos copiados"

# Paso 4: Subir a GitHub
echo ""
echo "Paso 4: Subiendo a GitHub..."
cd ~/git/Web-public
git add .
git commit -m "Deploy $(date +"%d/%m/%Y %H:%M")" 2>/dev/null || echo "No hay cambios"
git push origin master
echo "✓ Subido a GitHub"

echo ""
echo "======================================"
echo "   ¡COMPLETADO!"
echo "======================================"
echo "Tu sitio: https://web-angel1.netlify.app/"
