import os
import yaml


def create_directory(path):
    try:
        os.makedirs(path)
    except Exception as e:
        print(f'Failed to create directory {path}: {str(e)}')
        return False
    
    print(f'Created directory {path}')
    return True

def main():
    with open('pipe4.yaml', 'r') as f:
        schema = yaml.load(f, Loader=yaml.FullLoader)
    
    path_root = "."
    
    for key, value in schema.items():
        path_root += f"/{value}"
        if create_directory(path_root):
            print(f"Directory '{path_root}' created.")
        else:
            print(f"Failed to create directory '{path_root}'.")

if __name__ == '__main__':
    main()
