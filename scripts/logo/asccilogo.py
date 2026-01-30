import random
import argparse
import sys

def transform_file(input_file, color=None):
    """
    Lee un archivo y reemplaza cada 'x' con caracteres aleatorios de &=-<>?+
    """
    chars = list('&=-<>?+')
    
    # Códigos ANSI para colores
    colors = {
        'red': '\033[91m',
        'green': '\033[92m',
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'magenta': '\033[95m',
        'cyan': '\033[96m',
        'white': '\033[97m',
        'reset': '\033[0m'
    }
    
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        result = ''.join(
            random.choice(chars) if char.lower() == 'x' else char
            for char in content
        )
        
        # Aplica color si se especifica
        if color and color.lower() in colors:
            result = colors[color.lower()] + result + colors['reset']
        
        print(result)
        
    except FileNotFoundError:
        print(f"✗ Archivo no encontrado: {input_file}")
    except Exception as e:
        print(f"✗ Error: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--file', help='Archivo de entrada', required=True)
    parser.add_argument('-C', '--color', help='Color del texto (red, green, yellow, blue, magenta, cyan, white)')
    args = parser.parse_args()
    
    transform_file(args.file, args.color)
