from pydantic import BaseModel
from typing import Optional

class Product(BaseModel):
    productId: int
    supplierId: int
    name: str
    description: str
    price: float
    sku: str
    unit: str
    imgName: str
    discount: Optional[float] = None