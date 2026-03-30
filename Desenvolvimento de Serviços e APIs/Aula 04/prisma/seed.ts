import { prisma } from "../lib/prisma";
import { type Prisma } from "../generated/prisma/client"

const notebooks: Prisma.NotebooksCreateInput[]  = [
    {
        modelo: "Aspire Go 15",
        marca: "Acer",
        processador: "Intel",
        preco: 2800,
        quantidade: 3
    },
    { modelo: "Vivobook 15", marca: "Asus", processador: "AMD", preco: 3200, quantidade: 5 },
    { modelo: "Ideapad 3i", marca: "Lenovo", processador: "Intel", preco: 2950, quantidade: 8 },
    { modelo: "Book 2", marca: "Samsung", processador: "Intel", preco: 3100, quantidade: 12 },
    { modelo: "Vostro 3520", marca: "Dell", processador: "Intel", preco: 3500, quantidade: 4 },
    { modelo: "Modern 15", marca: "MSI", processador: "AMD", preco: 4200, quantidade: 2 },
    { modelo: "Nitro V", marca: "Acer", processador: "Intel", preco: 4800, quantidade: 6 },
    { modelo: "ThinkPad E14", marca: "Lenovo", processador: "AMD", preco: 5100, quantidade: 3 },
    { modelo: "Inspirion 15", marca: "Dell", processador: "AMD", preco: 3400, quantidade: 7 },
    { modelo: "Pavilion x360", marca: "HP", processador: "Intel", preco: 3900, quantidade: 5 },
    { modelo: "Zenbook 14", marca: "Asus", processador: "AMD", preco: 6500, quantidade: 2 },
    { modelo: "Galaxy Book3", marca: "Samsung", processador: "Intel", preco: 4300, quantidade: 9 },
    { modelo: "Alienware m16", marca: "Dell", processador: "Intel", preco: 12500, quantidade: 1 },
    { modelo: "Legion Slim 5", marca: "Lenovo", processador: "AMD", preco: 7800, quantidade: 4 },
    { modelo: "Swift 3", marca: "Acer", processador: "AMD", preco: 3700, quantidade: 10 },
    { modelo: "G15", marca: "Dell", processador: "AMD", preco: 5200, quantidade: 6 },
    { modelo: "Victus 16", marca: "HP", processador: "Intel", preco: 5600, quantidade: 4 },
    { modelo: "Katana GF66", marca: "MSI", processador: "Intel", preco: 6900, quantidade: 2 },
    { modelo: "Yoga 7i", marca: "Lenovo", processador: "Intel", preco: 7200, quantidade: 3 },
    { modelo: "TUF Gaming F15", marca: "Asus", processador: "Intel", preco: 5400, quantidade: 5 },
    { modelo: "Envy x360", marca: "HP", processador: "AMD", preco: 5800, quantidade: 3 }
]

async function main() {
    try {
        await prisma.notebooks.createMany({ data: notebooks })
        console.log(`${notebooks.length} Notebooks Cadastradas...`)
    } catch (error) {
        console.error("Erro nas Inclusões (Seeds):", error);
        throw error;
    } finally {
        await prisma.$disconnect();
    }
}

await main()
