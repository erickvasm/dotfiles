# MarkItDown

Herramienta de Microsoft para convertir archivos a Markdown. Útil para pasar documentos a LLMs.

Formatos soportados: PDF, Word, Excel, PowerPoint, imágenes, audio, HTML, CSV, JSON, XML, YouTube URLs, EPubs, ZIP.

## Instalación

```bash
pip install 'markitdown[all]'
```

O solo los formatos que necesitas:

```bash
pip install 'markitdown[pdf,docx,pptx]'
```

Opciones disponibles: `pdf`, `docx`, `xlsx`, `xls`, `pptx`, `outlook`, `audio-transcription`, `youtube-transcription`.

## Uso básico (CLI)

```bash
# Convertir e imprimir en terminal
markitdown archivo.pdf

# Guardar en archivo
markitdown archivo.pdf -o resultado.md

# Con pipe
cat archivo.pdf | markitdown
```

## Uso en Python

```python
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert("archivo.xlsx")
print(result.text_content)
```

## Con descripción de imágenes via LLM

```python
from markitdown import MarkItDown
from openai import OpenAI

client = OpenAI()
md = MarkItDown(llm_client=client, llm_model="gpt-4o")
result = md.convert("imagen.jpg")
print(result.text_content)
```

## Docker

```bash
docker build -t markitdown:latest .
docker run --rm -i markitdown:latest < archivo.pdf > output.md
```

## Plugins

```bash
# Ver plugins instalados
markitdown --list-plugins

# Usar plugins al convertir
markitdown --use-plugins archivo.pdf
```

## Notas

- Requiere Python 3.10+
- Output está pensado para LLMs, no para presentación humana
- Instalar en virtualenv para evitar conflictos de dependencias
