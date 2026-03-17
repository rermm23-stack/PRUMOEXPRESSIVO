
import UIKit
import CoreImage.CIFilterBuiltins

class PDFService {

    func gerar() {

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))

        let data = renderer.pdfData { ctx in
            ctx.beginPage()

            let title = "PRUMOEXPRESSIVO VISTORIAS\nRelatório Técnico"
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: nil)

            let qr = gerarQR(texto: "REL-0001")
            qr?.draw(in: CGRect(x: 450, y: 750, width: 100, height: 100))
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("relatorio.pdf")
        try? data.write(to: url)

        print("PDF criado:", url)
    }

    func gerarQR(texto: String) -> UIImage? {
        let data = texto.data(using: .ascii)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        if let output = filter.outputImage {
            let context = CIContext()
            if let cgimg = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return nil
    }
}
