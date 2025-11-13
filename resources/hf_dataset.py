import torch
from torch.utils.data import Dataset
from torchvision.transforms.functional import to_pil_image
import datasets

class HFDataset(Dataset):
    def __init__(self, file_path, transform=None):
        self.file_path = file_path
        self.transform = transform
        self._ds = datasets.load_from_disk(self.file_path).with_format('torch')

    def __len__(self):
        return len(self._ds)
    
    def __getitem__(self, idx):
        image = self._ds[idx]['image']
        image = to_pil_image(image)
        label = self._ds[idx]['label']

        if self.transform:
            image = self.transform(image)

        return image, label