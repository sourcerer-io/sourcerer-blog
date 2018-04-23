
import fs from 'fs-extra';

let fortunes;

async function readFortunes() {
    const fortunesfn = process.env.FORTUNE_FILE;
    const fortunedata = await fs.readFile(fortunesfn, 'utf8');
    fortunes = fortunedata.split('\n%\n').slice(1);
}

export default async function() {
    if (!fortunes) {
        await readFortunes();
    }
    if (!fortunes) {
        throw new Error('Could not read fortunes');
    }
    let f = fortunes[Math.floor(Math.random() * fortunes.length)];
    return f;
};