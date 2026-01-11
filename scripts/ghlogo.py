import random

def transform_file(input_file):
    """
    Lee un archivo y reemplaza cada 'x' con caracteres aleatorios de &=-<>?+
    """
    chars = list('&=-<>?+')
    
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Reemplaza cada 'x' (mayúscula y minúscula) con un carácter aleatorio
        result = ''.join(
            random.choice(chars) if char.lower() == 'x' else char
            for char in content
        )
        
        print(result)
        
    except FileNotFoundError:
        print(f"✗ Archivo no encontrado: {input_file}")
    except Exception as e:
        print(f"✗ Error: {e}")

if __name__ == "__main__":
    transform_file('/mnt/data/documents/dotfiles/assets/ghlogo.txt')
